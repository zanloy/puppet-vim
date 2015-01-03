define vim::config (
  $user,
  $content,
  $order = '05',
  $home = 'UNSET',
) {

  validate_string($content)

  if $home == 'UNSET' {
    if $user == 'root' {
      $home_real = '/root'
    } else {
      $home_real = "/home/${user}"
    }
  } else {
    $home_real = $home
  }

  $vimrc = "${home_real}/.vimrc"

  if ! defined(Concat[$vimrc]) {
    concat { $vimrc:
      ensure => present,
      owner  => $user,
      mode   => '0644',
    }
  }

  concat::fragment { "${user}-vimrc-${title}":
    target  => $vimrc,
    content => "${content}\n",
    order   => $order,
  }

}
