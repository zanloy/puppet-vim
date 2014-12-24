# Class: vim
#
# This module manages vim and sets it as default editor.
#
# Parameters:
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*autoupgrade*]
#     Upgrade package automatically, if there is a newer version.
#     Default: false
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know,
#       what you're doing.
#     Default: auto-set, platform specific
#
#   [*set_as_default*]
#     Set editor as default editor.
#     Default: auto-set, platform specific
#
#   [*set_editor_cmd*]
#     Command to set editor as default editor.
#     Only set this, if your platform is not supported or you know,
#       what you're doing.
#     Default: auto-set, platform specific
#
#   [*test_editor_set*]
#     Command to check, if editor is set as default.
#     Only set this, if your platform is not supported or you know,
#       what you're doing.
#     Default: auto-set, platform specific
#
#   [*conf_file*]
#     VIM's main configuration file.
#     Default: /etc/vim/vimrc (Debian), /etc/vimrc (RedHat)
#
#   [*opt_bg_shading*]
#     Terminal background colour. This affects the colour scheme
#       used by VIM to do syntax highlighting.
#     Valid values are either 'dark' or 'light'.
#     Default: dark
#
#   [*opt_indent*]
#     If true, Vim loads indentation rules and plugins according to
#       the detected filetype.
#     Default: true
#
#   [*opt_lastposition*]
#     If true, Vim jumps to the last known position when reopening a file.
#     Default: true
#
#   [*opt_powersave*]
#     If set to 'true' avoids cursor blinking that might wake up the processor.
#     Default: true
#
#   [*opt_syntax*]
#     Turns on syntax highlighting if supported by the terminal.
#     Default: true
#
#   [*opt_misc*]
#     Array containing options that will be set on VIM.
#     Default: ['hlsearch','showcmd','showmatch','ignorecase','smartcase',
#               'incsearch','autowrite','hidden']
#
#   [*opt_maps*]
#     Hash containing key maps that will be set on VIM.
#     Default: {}
#
#   [*opt_autocmds*]
#     Hash containing autocmds that will be set on VIM.
#     Default: ['FileType python setlocal shiftwidth=4 tabstop=4 backspace=4']
#
#   [*opt_statusline*]
#     The statusline to be displayed.
#     Default: %t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
#     Note: To disable statusline, set to empty string.
#
# Actions:
#   Installs vim and, if enabled, set it as default editor.
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'vim': }
#
class vim (
  $ensure             = 'UNSET',
  $autoupgrade        = 'UNSET',
  $package            = 'UNSET',
  $set_as_default     = 'UNSET',
  $set_editor_cmd     = 'UNSET',
  $test_editor_set    = 'UNSET',
  $conf_file          = 'UNSET',
  $opt_bg_shading     = 'UNSET',
  $opt_indent         = 'UNSET',
  $opt_lastposition   = 'UNSET',
  $opt_powersave      = 'UNSET',
  $opt_syntax         = 'UNSET',
  $opt_misc           = 'UNSET',
  $opt_maps           = 'UNSET',
  $opt_autocmds       = 'UNSET',
  $opt_statusline     = 'UNSET',
) {

  include vim::params

  $ensure_real = $ensure ? {
    'UNSET' => 'present',
    default => $ensure,
  }

  $autoupgrade_real = $autoupgrade ? {
    'UNSET' => 'present',
    default => $autoupgrade,
  }

  $package_real = $package ? {
    'UNSET' => $vim::params::package,
    default => $package,
  }

  $set_as_default_real = $set_as_default ? {
    'UNSET' => $vim::params::set_as_default,
    default => $set_as_default,
  }

  $set_editor_cmd_real = $set_editor_cmd ? {
    'UNSET' => $vim::params::set_editor_cmd,
    default => $set_editor_cmd,
  }

  $test_editor_set_real = $test_editor_set ? {
    'UNSET' => $vim::params::test_editor_set,
    default => $test_editor_set,
  }

  $conf_file_real = $conf_file ? {
    'UNSET' => $vim::params::conf_file,
    default => $conf_file,
  }

  $opt_bg_shading_real = $opt_bg_shading ? {
    'UNSET' => $vim::params::opt_bg_shading,
    default => $opt_bg_shading,
  }

  $opt_indent_real = $opt_indent ? {
    'UNSET' => $vim::params::opt_indent,
    default => $opt_indent,
  }

  $opt_lastposition_real = $opt_lastposition ? {
    'UNSET' => $vim::params::opt_lastposition,
    default => $opt_lastposition,
  }

  $opt_powersave_real = $opt_powersave ? {
    'UNSET' => $vim::params::opt_powersave,
    default => $opt_powersave,
  }

  $opt_syntax_real = $opt_syntax ? {
    'UNSET' => $vim::params::opt_syntax,
    default => $opt_syntax,
  }

  $opt_misc_real = $opt_misc ? {
    'UNSET' => $vim::params::opt_misc,
    default => $opt_misc,
  }

  $opt_maps_real = $opt_maps ? {
    'UNSET' => $vim::params::opt_maps,
    default => $opt_maps,
  }

  $opt_autocmds_real = $opt_autocmds ? {
    'UNSET' => $vim::params::opt_autocmds,
    default => $opt_autocmds,
  }

  $opt_statusline_real = $opt_statusline ? {
    'UNSET' => $vim::params::opt_statusline,
    default => $opt_statusline,
  }

  ### END VARIABLE PARSING

  case $ensure_real {
    /(present)/: {
      if $autoupgrade_real == true {
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

  package { $package_real:
    ensure => $package_ensure,
  }

  file { $conf_file_real:
    ensure  => $file_ensure,
    content => template('vim/vimrc.erb'),
  }

  if $set_as_default_real {
    exec { $set_editor_cmd_real:
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      unless  => $test_editor_set_real,
      require => Package[$package_real],
    }
  }
}
