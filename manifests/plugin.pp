define vim::plugin (
  $user,
  $url,
  $home = 'UNSET'
) {

  validate_string($user, $url)

  if $home == 'UNSET' {
    if $user == 'root' {
      $home_real = '/root'
    } else {
      $home_real = "/home/${user}"
    }
  } else {
    $home_real = $home
  }

  if ! defined(Package['git']) {
    package { 'git':
      ensure => present,
    }
  }

  exec { "${user}-${title}":
    creates => "${home_real}/.vim/bundle/${title}",
    path    => ['/bin', '/usr/bin'],
    command => "git clone ${url} ${home_real}/.vim/bundle/${title}",
    user    => $user,
    require => Package['git'],
  }

}
