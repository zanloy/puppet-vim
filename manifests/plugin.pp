define vim::plugin (
  $user,
  $url,
  $name = $title,
  $home = 'UNSET',
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

  exec { "vim::plugin-${user}-${title}":
    creates => "${home_real}/.vim/bundle/${name}/.git",
    path    => ['/bin', '/usr/bin'],
    cwd     => "${home_real}/.vim/bundle",
    command => "git clone ${url} ${name}",
    user    => $user,
    require => [Package['git'], File["${home_real}/.vim/bundle"]],
  }

}
