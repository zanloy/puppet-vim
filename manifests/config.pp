class vim::config (
  $conf_file        = $vim::params::conf_file,
  $opt_bg_shading   = $vim::params::opt_bg_shading,
  $opt_indent       = $vim::params::opt_indent,
  $opt_lastposition = $vim::params::opt_lastposition,
  $opt_powersave    = $vim::params::opt_powersave,
  $opt_syntax       = $vim::params::opt_syntax,
  $opt_misc         = $vim::params::opt_misc,
  $opt_maps         = $vim::params::opt_maps,
  $opt_autocmds     = $vim::params::opt_autocmds,
  $opt_statusline   = $vim::params::opt_statusline,
) inherits vim::params {

  concat { $conf_file:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment { 'vimrc_header':
    target  => $conf_file,
    content => "\" vimrc: Managed by puppet - DO NOT EDIT\n\n",
    order   => '01',
  }

  concat::fragment { 'vimrc_main':
    target  => $conf_file,
    content => template('vim/vimrc.erb'),
    order   => '50',
  }

  define vim::fragment($content="", $order='10') {
    if $content == "" {
      $body = $name
    } else {
      $body = $content
    }   

    concat::fragment{ "vimrc_fragment_${name}":
      target => $conf_file,
      order => $order,
      content => $body,
    }   
  }
}
