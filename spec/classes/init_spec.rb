require 'spec_helper'

describe 'vim' do
  context 'on ArchLinux' do
    let(:facts) {
      { osfamily: 'ArchLinux' }
    }
    context 'installs vim' do
      it { should contain_package('vim')}
      it { should contain_file('/etc/vimrc')}
      it { should contain_exec('eselect editor set /usr/bin/vim')}
    end
  end

  context 'on Debian' do
    let(:facts) {
      { osfamily: 'Debian' }
    }
    context 'installs vim' do
      it { should contain_package('vim-nox')}
      it { should contain_file('/etc/vim/vimrc')}
      it { should contain_exec('update-alternatives --set editor /usr/bin/vim.nox')}
    end
  end

  context 'on FreeBSD' do
    let(:facts) {
      { osfamily: 'FreeBSD' }
    }
    context 'installs vim' do
      it { should contain_package('vim-lite')}
      it { should contain_file('/etc/vimrc')}
    end
  end

  context 'on Gentoo' do
    let(:facts) {
      { osfamily: 'Gentoo' }
    }
    context 'installs vim' do
      it { should contain_package('app-editors/vim')}
      it { should contain_file('/etc/vimrc')}
      it { should contain_exec('eselect editor set /usr/bin/vim')}
    end
  end

  context 'on RedHat' do
    let(:facts) {
      { osfamily: 'RedHat' }
    }
    context 'installs vim' do
      it { should contain_package('vim-enhanced')}
      it { should contain_file('/etc/vimrc')}
    end
  end

  context 'on Suse' do
    let(:facts) {
      { osfamily: 'Suse' }
    }
    context 'installs vim' do
      it { should contain_package('vim')}
      it { should contain_file('/etc/vimrc')}
    end
  end

  context 'creates vimrc' do
    let(:facts) {
      { osfamily: 'RedHat' }
    }
    context 'with default opt_bg_shading' do
      it do
        should contain_file('/etc/vimrc') \
          .with_content(/^set background=dark$/)
      end
    end
    context 'with light opt_bg_shading' do
      let(:params) {
        { opt_bg_shading: 'light' }
      }
      it do
        should contain_file('/etc/vimrc') \
          .with_content(/^set background=light$/)
      end
    end
    context 'with default opt_indent' do
      it do
        should contain_file('/etc/vimrc') \
          .with_content(/^\s*filetype plugin indent on$/)
      end
    end
    context 'without opt_indent' do
      let(:params) {
        { opt_indent: false }
      }
      it do
        should contain_file('/etc/vimrc') \
          .without_content(/^\s*filetype plugin indent on$/)
      end
    end
    context 'with default opt_lastposition' do
      it do
        should contain_file('/etc/vimrc') \
          .with_content(/^\s*au BufReadPost .*$/)
      end
    end
    context 'without opt_lastposition' do
      let(:params) {
        { opt_lastposition: false }
      }
      it do
        should contain_file('/etc/vimrc') \
          .without_content(/^\s*au BufReadPost .*$/)
      end
    end
    context 'with default opt_powersave' do
      it do
        should contain_file('/etc/vimrc') \
        .with_content(/^let &guicursor = &guicursor . ",a:blinkon0"$/)
      end
    end
    context 'without opt_powersave' do
      let(:params) {
        { opt_powersave: false }
      }
      it do
        should contain_file('/etc/vimrc') \
        .without_content(/^let &guicursor = &guicursor . ",a:blinkon0"$/)
      end
    end
    context 'with default opt_syntax' do
      it do
        should contain_file('/etc/vimrc') \
        .with_content(/^\s*syntax on$/)
      end
    end
    context 'without opt_syntax' do
      let(:params) {
        { opt_syntax: false }
      }
      it do
        should contain_file('/etc/vimrc') \
        .without_content(/^\s*syntax on$/)
      end
    end
    # Not testing opt_misc or opt_maps here because it's too dynamic
    context 'with default opt_statusline' do
      it do
        should contain_file('/etc/vimrc') \
        .with_content(/^set statusline=.*$/)
      end
    end
    context 'without opt_statusline' do
      let(:params) {
        { opt_statusline: '' }
      }
      it do
        should contain_file('/etc/vimrc') \
        .without_content(/^set statusline=.*$/)
      end
    end
  end
end
