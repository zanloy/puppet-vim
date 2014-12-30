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

  exec { "${user}-${title}":
    creates => "${home_real}/.vim/bundle/${title}",
    command => "/usr/bin/git clone ${url} ${home_real}/.vim/bundle/${title}",
    user    => $user,
  }

}
