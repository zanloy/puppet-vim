include vim

class { 'vim::pathogen':
  user => 'vagrant',
}

$plugins = {
  'nerdtree'         => { url => 'https://github.com/scrooloose/nerdtree.git' },
  'syntastic'        => { url => 'https://github.com/scrooloose/syntastic.git'},
  'vim-airline'      => { url => 'https://github.com/bling/vim-airline' },
  'vim-commentary'   => { url => 'https://github.com/tpope/vim-commentary.git' },
  'vim-endwise'      => { url => 'https://github.com/tpope/vim-endwise.git' },
  'vim-fugitive'     => { url => 'https://github.com/tpope/vim-fugitive.git' },
  'vim-gitgutter'    => { url => 'https://github.com/airblade/vim-gitgutter.git' },
  'vim-indentobject' => { url => 'https://github.com/austintaylor/vim-indentobject.git' },
  'vim-rails'        => { url => 'https://github.com/tpope/vim-rails.git' },
  'vim-repeat'       => { url => 'https://github.com/tpope/vim-repeat.git' },
  'vim-ruby'         => { url => 'https://github.com/vim-ruby/vim-ruby.git' },
  'vim-slim'         => { url => 'https://github.com/slim-template/vim-slim.git' },
}

create_resources(vim::plugin, $plugins, { 'user' => 'vagrant' })

#vim::plugin { 'vim-commentary':
#  user => 'vagrant',
#  url => 'https://github.com/tpope/vim-commentary.git',
#}
