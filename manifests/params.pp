# This class is to contain the default options for vim
class vim::params {

  # vim os-specific options
  case $::osfamily {
    archlinux: {
      $package         = 'vim'
      $editor_name     = 'vim'
      $set_as_default  = false
      $set_editor_cmd  = '/bin/true'
      $test_editor_set = '/bin/true'
      $conf_file       = '/etc/vimrc'
    }
    debian: {
      $package         = 'vim-nox'
      $editor_name     = 'vim.nox'
      $set_as_default  = true
      $set_editor_cmd  = "update-alternatives --set editor /usr/bin/${editor_name}"
      $test_editor_set = "test /etc/alternatives/editor -ef /usr/bin/${editor_name}"
      $conf_file       = '/etc/vim/vimrc'
    }
    freebsd: {
      $package         = 'vim-lite'
      $editor_name     = 'vim'
      $set_as_default  = false
      $set_editor_cmd  = '/bin/true'
      $test_editor_set = '/bin/true'
      $conf_file       = '/etc/vimrc'
    }
    gentoo: {
      $package         = 'app-editors/vim'
      $editor_name     = 'vim'
      $set_as_default  = true
      $set_editor_cmd  = "eselect editor set /usr/bin/${editor_name}"
      $test_editor_set = "eselect editor show|grep /usr/bin/${editor_name}"
      $conf_file       = '/etc/vimrc'
    }
    redhat: {
      $package         = 'vim-enhanced'
      $editor_name     = 'vim'
      $set_as_default  = false
      $set_editor_cmd  = '/bin/true'
      $test_editor_set = '/bin/true'
      $conf_file       = '/etc/vimrc'
    }
    suse: {
      $package         = 'vim'
      $editor_name     = 'vim'
      $set_as_default  = false
      $set_editor_cmd  = '/bin/true'
      $test_editor_set = '/bin/true'
      $conf_file       = '/etc/vimrc'
    }
    default: {
      fail("Unsupported platform: osfamily = ${::osfamily}")
    }
  }

  $ensure           = 'present'
  $autoupgrade      = false

  # vimrc default options
  $opt_bg_shading   = 'dark'
  $opt_indent       = true
  $opt_lastposition = true
  $opt_powersave    = true
  $opt_syntax       = true
  $opt_misc         = []
  $opt_maps         = {}
  $opt_autocmds     = ['FileType python setlocal shiftwidth=4 tabstop=4']
  $opt_statusline   = "%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\\ %P"

}
