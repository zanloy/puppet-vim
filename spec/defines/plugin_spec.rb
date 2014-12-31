require 'spec_helper'

describe 'vim::plugin', :type => :define do
  context 'creates git cmd' do
    let(:title) { 'vim-commentary' }
    let(:params) { {user: 'user1', url: 'https://github.com/tpope/vim-commentary.git'} }
    it do
      should contain_exec('user1-vim-commentary')
        .with_creates('/home/user1/.vim/bundle/vim-commentary')
        .with_command('git clone https://github.com/tpope/vim-commentary.git /home/user1/.vim/bundle/vim-commentary')
        .with_user('user1')
    end
  end
  context 'errors without user' do
    let(:title) { 'vim-commentary' }
    let(:params) { { url: 'https://github.com/tpope/vim-commentary.git'} }
    it { expect { should compile }.to raise_error }
  end
  context 'errors without url' do
    let(:title) { 'vim-commentary' }
    let(:params) { { user: 'user1'} }
    it { expect { should compile }.to raise_error }
  end
end #describe
