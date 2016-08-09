require 'spec_helper'

testcases = {
  'case1' => { title: 'vimrc_1', params: { user: 'user11', content: 'colorscheme brg256', order: '05'} },
  'case2' => { title: 'vimrc_2', params: { user: 'user21', content: 'colorscheme brg256', order: '05'} },
  'case3' => { title: 'vimrc_31', params: { user: 'user31', content: 'colorscheme brg256', home: '/home/local/user31'} },
}

describe 'vim::config', :type => :define do
  testcases.each do |name, values|
    if values[:params][:home]
      concat_file = "#{values[:params][:home]}/.vimrc"
    else
      if values[:params][:user] == 'root'
        concat_file = '/root/.vimrc'
      else
        concat_file = "/home/#{values[:params][:user]}/.vimrc"
      end
    end
    context "using test case '#{name}' for user #{values[:params][:user]}" do
      let(:facts) { { concat_basedir: '/tmp' } }
      let(:title) { "#{values[:title]}" }
      let(:params) { values[:params] }
      context "create the concat object '#{name}' for user #{values[:params][:user]}" do
        it do
          should contain_concat("#{concat_file}")
            .with({"owner"=>"#{values[:params][:user]}",
                   "mode"=>"0644"})
        end
      end
      context "adds content to .vimrc '#{name}' for user #{values[:params][:user]}" do
        it do
          values[:params][:order] ||= '05'
          should contain_concat__fragment("#{values[:params][:user]}-vimrc-#{title}")
            .with_target("#{concat_file}")
            .with_content("#{values[:params][:content]}\n")
            .with_order(values[:params][:order])
        end
      end
    end
  end #testcases.each
  context 'errors without user' do
    let(:title) { testcases[:case1][:title] }
    let(:params) { { content: testcases[:case1][:params][:content] } }
    it { expect { should compile }.to raise_error }
  end
end #describe
