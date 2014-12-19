class vim::params {
  $background   = 'dark'
  $lastposition = true
  $indent       = true
  $powersave    = true
  $syntax       = true
  $misc         = ['hlsearch','showcmd','showmatch','ignorecase','smartcase','incsearch','autowrite','hidden']
  $maps         = {}
  $autocmds     = ['FileType python setlocal shiftwidth=4 tabstop=4 backspace=4']
  case $::osfamily {
    debian: {
      $package         = 'vim-nox'
      $editor_name     = 'vim.nox'
      $set_as_default  = true
      $set_editor_cmd  = "update-alternatives --set editor /usr/bin/${editor_name}"
      $test_editor_set = "test /etc/alternatives/editor -ef /usr/bin/${editor_name}"
      $conf            = '/etc/vim/vimrc'
    }
    redhat: {
      $package        = 'vim-enhanced'
      $set_as_default = false
      $conf           = '/etc/vimrc'
    }
    freebsd: {
      $package        = 'vim-lite'
      $set_as_default = false
    }
    suse: {
      $package        = 'vim'
      $set_as_default = false
      $conf           = '/etc/vimrc'
    }
    gentoo: {
      $package         = 'app-editors/vim'
      $set_as_default  = true
      $set_editor_cmd  = 'eselect editor set /usr/bin/vim'
      $test_editor_set = 'eselect editor show|grep /usr/bin/vim'
      $conf            = '/etc/vimrc'
    }
    archlinux: {
      $package         = 'vim'
      $set_as_default  = false
      $conf            = '/etc/vimrc'
    }
    default: {
      case $::operatingsystem {
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
