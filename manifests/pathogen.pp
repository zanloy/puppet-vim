class vim::pathogen (
  $user = undef,
  $home = undef,
) {

  #validate_string($user)

  include ::wget

  if $home == undef {
    if $user == 'root' {
      $home_real = '/root'
    } else {
      $home_real = "/home/${user}"
    }
  } else {
    $home_real = $home
  }

  # Setup directories
  file { ["${home_real}/.vim", "${home_real}/.vim/autoload", "${home_real}/.vim/bundle"]:
    ensure => directory,
    owner  => $user,
  }

  # Install pathogen.vim
  wget::fetch { 'wget-pathogen':
    source      => 'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim',
    destination => "${home_real}/.vim/autoload/pathogen.vim",
    require     => File["${home_real}/.vim/autoload/pathogen.vim"],
  }

}
