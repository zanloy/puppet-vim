require 'spec_helper'

osfamilies = {
  'ArchLinux' => '/etc/vimrc',
  'Debian'    => '/etc/vim/vimrc',
  'FreeBSD'   => '/etc/vimrc',
  'Gentoo'    => '/etc/vimrc',
  'RedHat'    => '/etc/vimrc',
  'Suse'      => '/etc/vimrc',
}

describe 'vim' do
  osfamilies.each do |osfamily, conf_file|
    context "on #{osfamily}" do
      let(:facts) { { osfamily: osfamily, concat_basedir: '/tmp' } }
      context 'creates vimrc with default values' do
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .with_content(/^\s*set background=dark$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .with_content(/^\s*filetype plugin indent on$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .with_content(/^\s*au BufReadPost .*$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .with_content(/^\s*let &guicursor = &guicursor . ",a:blinkon0"$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .with_content(/^\s*syntax on$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .without_content(/^\s*set statusline=/)
        end
      end
      context 'create vimrc with custom values' do
        let(:params) do
	        { opt_bg_shading: 'light', \
            opt_indent: false, \
            opt_lastposition: false, \
            opt_powersave: false, \
            opt_syntax: false, \
            opt_statusline: '' }
        end
        it { should contain_file(conf_file) }
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .with_content(/^\s*set background=light$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .without_content(/^\s*filetype plugin indent on$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .without_content(/^\s*au BufReadPost .*$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .without_content(/^\s*let &guicursor = &guicursor . ",a:blinkon0"$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .without_content(/^\s*syntax on$/)
        end
        it do
          should contain_concat__fragment('vimrc_main')
            .with_target(conf_file)
            .without_content(/^\s*set statusline=/)
        end
      end
    end
  end #osfamilies.each
end #describe
