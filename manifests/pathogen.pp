define vim::pathogen (
  $user = $name,
  $home = 'UNSET',
) {

  validate_string($user)

  if ! defined(Package['curl']) {
    package { 'curl':
      ensure => present,
    }
  }

  if $home == 'UNSET' {
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
  } ->

  exec { "curl_pathogen_for_${user}":
    creates => "${home_real}/.vim/autoload/pathogen.vim",
    path    => ['/bin', '/usr/bin', '/usr/local/bin'],
    command => "curl -LSso ${home_real}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim",
    require => Package['curl'],
  } ->

  file { "${home_real}/.vim/autoload/pathogen.vim":
    owner   => $user,
    require => Exec[ "curl_pathogen_for_${user}"],
  } ->

  vim::config { "pathogen_${user}":
    user    => $user,
    content => 'execute pathogen#infect()',
    order   => '01',
  }

  File["${home_real}/.vim"] -> File["${home_real}/.vim/autoload"] -> File["${home_real}/.vim/bundle"]

}
