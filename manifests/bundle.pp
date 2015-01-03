# This is a manifest to install plugins recommended
# by the author <zan.loy@gmail.com>
#
# If you have any great vim plugins that you like,
# please drop me a line and I'll look at it.
#
define vim::bundle (
  $user = $name,
  $home = 'UNSET'
) {

  validate_string($user)

  if ! defined(Vim::Pathogen[$user]) {
    vim::pathogen { $user: home => $home }
  }

  $plugins = {
    'nerdtree'          => { url => 'https://github.com/scrooloose/nerdtree.git' },
    'syntastic'         => { url => 'https://github.com/scrooloose/syntastic.git'},
    'vim-airline'       => { url => 'https://github.com/bling/vim-airline.git' },
    'vim-bufferline'    => { url => 'https://github.com/bling/vim-bufferline' },
    'vim-colors-grb256' => { url => 'https://github.com/zanloy/vim-colors-grb256.git' },
    'vim-commentary'    => { url => 'https://github.com/tpope/vim-commentary.git' },
    'vim-endwise'       => { url => 'https://github.com/tpope/vim-endwise.git' },
    'vim-fugitive'      => { url => 'https://github.com/tpope/vim-fugitive.git' },
    'vim-gitgutter'     => { url => 'https://github.com/airblade/vim-gitgutter.git' },
    'vim-indentobject'  => { url => 'https://github.com/austintaylor/vim-indentobject.git' },
    'vim-rails'         => { url => 'https://github.com/tpope/vim-rails.git' },
    'vim-repeat'        => { url => 'https://github.com/tpope/vim-repeat.git' },
    'vim-ruby'          => { url => 'https://github.com/vim-ruby/vim-ruby.git' },
    'vim-slim'          => { url => 'https://github.com/slim-template/vim-slim.git' },
  }

  create_resources(vim::plugin, $plugins, { 'user' => $user, 'home' => $home })

}
