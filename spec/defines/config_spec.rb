require 'spec_helper'

title = 'colorscheme'
content = 'colorscheme brg256'
testcases = {
  'case1' => { params: { user: 'user1', content: content }, expected_home: '/home/user1' },
  'case2' => { params: { user: 'user2', content: content, home: '/home/local/user2' }, expected_home: '/home/local/user2' },
  'case3' => { params: { user: 'root', content: content, order: '10' }, expected_home: '/root' },
}

describe 'vim::config', :type => :define do
  testcases.each do |name, values|
    context "using test case '#{name}'" do
      let(:facts) { { concat_basedir: '/tmp' } }
      let(:title) { title }
      let(:params) { values[:params] }
      context 'create the concat object' do
        it do
          should contain_concat("#{values[:expected_home]}/.vimrc")
        end
      end
      context 'adds content to .vimrc' do
        it do
          values[:params][:order] ||= '05'
          should contain_concat__fragment("#{values[:params][:user]}-vimrc-#{title}")
            .with_target("#{values[:expected_home]}/.vimrc")
            .with_content("#{content}\n")
            .with_order(values[:params][:order])
        end
      end
    end
  end #testcases.each
  context 'errors without user' do
    let(:title) { title }
    let(:params) { { content: content } }
    it { expect { should compile }.to raise_error }
  end
end #describe
