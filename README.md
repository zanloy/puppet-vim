# puppet-vim

[![Build Status](https://travis-ci.org/zanloy/puppet-vim.svg?branch=master)](https://travis-ci.org/zanloy/puppet-vim)

Manage VIM via puppet.

Vim is an advanced text editor that seeks to provide the power of the de-facto Unix editor 'Vi', with a more complete feature set. 

## Sample Usage
Install VIM and use the provided configuration defaults

```
class { 'vim': }
```

Turn on line numbering

```
class { 'vim':
  opt_misc => ['number'],
}
```

Set F5 key to save and execute current file

```
class { 'vim':
  opt_maps => { '<F5>': '<Esc>:w<CR>:!%:p<CR>' },
}
```

Install [pathogen](https://github.com/tpope/vim-pathogen) for user 'johndoe'

```
vim::pathogen { 'johndoe': }
```

Install a plugin for user 'johndoe'.
Using [vim-commentary](https://github.com/tpope/vim-commentary) as an example.
Be sure to install pathogen or the plugins won't load in vim for that user.

```
vim::plugin { 'vim-commentary': url => 'https://github.com/tpope/vim-commentary.git' }
```

Install a bundle of plugins recommended by this module's author. This will
install pathogen for the user so defining it will not be necessary.

```
vim::bundle { 'johndoe': }
```

_Note: The bundle installs [vim-airline](https://github.com/bling/vim-airline) which
is a statusline replacement. By default it tries to use some special characters
to make it pretty. I initially had issues with getting these to work. Read
this [wiki](https://github.com/bling/vim-airline/wiki/FAQ) for answers on why
you don't have colors or special symbols._

Change colorscheme for user johndoe to grb256 (installed with bundle)

```
vim::config { 'colorscheme':
  user    => 'johndoe',
  content => 'colorscheme grb256',
}
```

Uninstall vim

```
class { 'vim':
  ensure => absent,
}
```

## Class parameters
* set_as_default
  * Accepted values: true or false
  * Default: true
  * Description: Set VIM as default editor.

* ensure 
  * Accepted values: present or absent 
  * Default: present
  * Description: Whether or not VIM will be installed

* autoupgrade 
  * Accepted values: true or false
  * Default: false
  * Description: Whether or not the VIM package should be automatically kept
    up-to-date using the distribution's packaging system

* set_editor_cmd
  * Accepted values: string
  * Default: update-alternatives --set editor /usr/bin/${editor_name} (Debian)
  * Description: The command used to set VIM as the default editor. Be careful
    if you're setting this parameter.

* test_editor_set 
  * Accepted values: string
  * Default: test /etc/alternatives/editor -ef /usr/bin/${editor_name} (Debian)
  * Description: Command used to verify that VIM is the default editor. Be
    careful if you're setting this parameter.

* conf_file
  * Accepted values: string
  * Default: /etc/vim/vimrc (Debian), /etc/vimrc (RedHat)
  * Description: Path to VIM's main configuration file.

* opt_bg_shading
  * Accepted values: dark or light
  * Default: dark
  * Description: Terminal background colour. This affects the colour scheme used
    by VIM to do syntax highlighting.

* opt_indent
  * Accepted values: true or false
  * Default: true
  * Description: If true, Vim loads indentation rules and plugins according to
    the detected filetype.

* opt_lastposition
  * Accepted values: true or false
  * Default: true
  * Description: If true, Vim jumps to the last known position when reopening a
    file.

* opt_powersave
  * Accepted values: true or false
  * Default: true
  * Description: If set to 'true' avoids cursor blinking that might wake up the
    processor.

* opt_syntax
  * Accepted values: true or false
  * Default: true
  * Description: Turns on syntax highlighting if supported by the terminal.

* opt_misc
  * Accepted values: array
  * Default: []
  * Description: Array containing options that will be set on VIM. Anything
    contained here will show as a "set option" line in your vimrc.

* opt_maps
  * Accepted values: hash
  * Default: {}
  * Description: Hash containing keybinds for use in "map <k> <v>" lines in your
    vimrc.

## Acknowlegments
This module was forked from the one originally written by [Saz](https://github.com/saz/puppet-vim). It adds enterprise linux support and configuration file management, which were not present.
