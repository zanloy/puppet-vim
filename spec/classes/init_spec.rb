require 'spec_helper'

osfamilies = {
  'ArchLinux' => { package: 'vim', conf_file: '/etc/vimrc' },
  'Debian'    => { package: 'vim-nox', conf_file: '/etc/vim/vimrc', editor_set: 'update-alternatives --set editor /usr/bin/vim.nox' },
  'FreeBSD'   => { package: 'vim-lite', conf_file: '/etc/vimrc' },
  'Gentoo'    => { package: 'app-editors/vim', conf_file: '/etc/vimrc', editor_set: 'eselect editor set /usr/bin/vim' },
  'RedHat'    => { package: 'vim-enhanced', conf_file: '/etc/vimrc' },
  'Suse'      => { package: 'vim', conf_file: '/etc/vimrc' }
}

describe 'vim' do
  osfamilies.each do |osfamily, values|
    context "on #{osfamily}" do
      let(:facts) { { osfamily: osfamily, concat_basedir: '/tmp' } }
      context 'installs vim' do
        it { should contain_package(values[:package]) }
      end
      context 'manages vimrc' do
        it { should contain_file(values[:conf_file]) }
      end
      context 'sets vim as default editor' do
        if values.has_key? :editor_set
          it { should contain_exec(values[:editor_set]) }
        else
          it { should_not contain_exec }
        end
      end
    end
  end #osfamilies.each
end #describe
