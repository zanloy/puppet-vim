require 'spec_helper'

testcases = {
  'case1' => { user: 'user1', params: {}, expected_home: '/home/user1' },
  'case2' => { user: 'user2', params: { home: '/home/local/user2' }, expected_home: '/home/local/user2' },
  'case3' => { user: 'root', params: {}, expected_home: '/root' },
}

describe 'vim::pathogen', :type => :define do
  testcases.each do |name, values|
    context "using test case '#{name}'" do
      let(:facts) { { concat_basedir: '/tmp' } }
      let(:title) { values[:user] }
      let(:params) { values[:params] }
      context 'creates proper directories' do
        it { should contain_file("#{values[:expected_home]}/.vim") }
        it { should contain_file("#{values[:expected_home]}/.vim/autoload") }
        it { should contain_file("#{values[:expected_home]}/.vim/bundle") }
      end
      context 'downloads pathogen.vim' do
        it do
          should contain_exec('curl-pathogen')
            .with_command("curl -LSso #{values[:expected_home]}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim")
            .with_creates("#{values[:expected_home]}/.vim/autoload/pathogen.vim")
        end
      end
      context 'adds pathogen#infect to .vimrc' do
        it do
          should contain_vim__config('pathogen')
            .with_content('execute pathogen#infect()')
        end
      end
    end
  end
end #describe
