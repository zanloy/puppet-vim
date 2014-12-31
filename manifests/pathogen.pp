define vim::pathogen (
  $user = $name,
  $home = undef,
) {

  validate_string($user)

  if ! defined(Package['curl']) {
    package { 'curl':
      ensure => present,
    }
  }

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

  exec { 'curl-pathogen':
    creates => "${home_real}/.vim/autoload/pathogen.vim",
    command => "${vim::params::curl_cmd} -LSso ${home_real}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim",
    require => Package['curl'],
  }

  file { "${home_real}/.vim/autoload/pathogen.vim":
    owner   => $user,
    require => Exec['curl-pathogen'],
  }

  file { "${home_real}/.vimrc":
    ensure  => file,
    content => "execute pathogen#infect()\n",
    owner   => $user,
  }

}
