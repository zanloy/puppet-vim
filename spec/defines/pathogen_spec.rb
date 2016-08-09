require 'spec_helper'

testcases = {
  'case1' => [
    { user: 'user11', params: {}, expected_home: '/home/user11' },
  ],
  'case2' => [
    { user: 'user21', params: { home: '/home/local/user21' }, expected_home: '/home/local/user21' },
  ],
  'case3' => [
    { user: 'root', params: {}, expected_home: '/root' },
    { user: 'user31', params: { home: '/home/local/user31' }, expected_home: '/home/local/user31' },
  ],
  'case4' => [
    { user: 'root', params: {}, expected_home: '/root' },
    { user: 'user41', params: { home: '/home/local/user41' }, expected_home: '/home/local/user41' },
    { user: 'user42', params: {}, expected_home: '/home/user42' },
  ]
}

describe 'vim::pathogen', :type => :define do
  testcases.each do |name, values|
    values.each do |user_values|
      context "using test case '#{name}'" do
        let(:facts) { { concat_basedir: '/tmp' } }
        let(:title) { user_values[:user] }
        let(:params) { user_values[:params] }
        context 'creates proper directories' do
          it { should contain_file("#{user_values[:expected_home]}/.vim") }
          it { should contain_file("#{user_values[:expected_home]}/.vim/autoload") }
          it { should contain_file("#{user_values[:expected_home]}/.vim/bundle") }
        end
        context 'downloads pathogen.vim' do
          it do
            should contain_exec("curl_pathogen_for_#{user_values[:user]}")
              .with_command("curl -LSso #{user_values[:expected_home]}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim")
              .with_creates("#{user_values[:expected_home]}/.vim/autoload/pathogen.vim")
          end
        end
        context 'adds pathogen#infect to .vimrc' do
          it do
            should contain_vim__config("pathogen_#{user_values[:user]}")
              .with_content('execute pathogen#infect()')
          end
        end
      end
    end
  end
end #describe
