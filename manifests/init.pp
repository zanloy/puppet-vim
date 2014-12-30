# View README.md for full documentation
#
# === Authors
#
# Zan Loy <zan.loy@gmail.com>
#
# === Copyright
#
# Copyright 2014
#
class vim (
  $ensure             = $vim::params::ensure,
  $autoupgrade        = $vim::params::autoupgrade,
  $package            = $vim::params::package,
  $set_as_default     = $vim::params::set_as_default,
  $set_editor_cmd     = $vim::params::set_editor_cmd,
  $test_editor_set    = $vim::params::test_editor_set,
  $conf_file          = $vim::params::conf_file,
  $opt_bg_shading     = $vim::params::opt_bg_shading,
  $opt_indent         = $vim::params::opt_indent,
  $opt_lastposition   = $vim::params::opt_lastposition,
  $opt_powersave      = $vim::params::opt_powersave,
  $opt_syntax         = $vim::params::opt_syntax,
  $opt_misc           = $vim::params::opt_misc,
  $opt_maps           = $vim::params::opt_maps,
  $opt_autocmds       = $vim::params::opt_autocmds,
  $opt_statusline     = $vim::params::opt_statusline,
) inherits vim::params {

  case $ensure {
    /(present)/: {
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
      $file_ensure = 'file'
    }
    /(absent)/: {
      $package_ensure = 'absent'
      $file_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

  file { $conf_file:
    content => template('vim/vimrc.erb'),
    owner   => 'root',
    mode    => '0644',
  }

  if $set_as_default {
    exec { $set_editor_cmd:
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      unless  => $test_editor_set,
      require => Package[$package],
    }
  }
}
