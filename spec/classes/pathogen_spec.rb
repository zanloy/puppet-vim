require 'spec_helper'

testcases = {
  'case1' => { params: { user: 'user1' }, expected_home: '/home/user1' },
  'case2' => { params: { home: '/home/user2' }, expected_home: '/home/user2' },
  'case3' => { params: { user: 'root' }, expected_home: '/root' },
}

describe 'vim::pathogen' do

  testcases.each do |name, values|
    context "using test case '#{name}'" do
      let(:params) { values[:params] }

      context 'creates proper directories' do
        it { should contain_file("#{values[:expected_home]}/.vim") }
        it { should contain_file("#{values[:expected_home]}/.vim/autoload") }
        it { should contain_file("#{values[:expected_home]}/.vim/bundle") }
      end

      context 'downloads pathogen.vim' do
        it do
          should contain_exec('curl-pathogen')
            .with_command("/bin/curl -LSso #{values[:expected_home]}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim")
            .with_creates("#{values[:expected_home]}/.vim/autoload/pathogen.vim")
        end
      end
    end
  end

end #describe
