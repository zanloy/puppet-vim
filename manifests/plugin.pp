define vim::plugin (
  $user,
  $url,
  $plugin,
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

  exec { "${user}-${plugin}":
    creates => "${home_real}/.vim/bundle/${plugin}/.git",
    path    => ['/bin', '/usr/bin'],
    cwd     => "${home_real}/.vim/bundle",
    command => "git clone ${url} ${plugin}",
    user    => $user,
    require => [Package['git'], File["${home_real}/.vim/bundle"]],
  }

}
