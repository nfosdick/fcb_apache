class fcb_apache::linux(
  $vhosts_defaults = $fcb_apache::vhosts_defaults, 
  $vhosts          = $fcb_apache::vhosts,
  $apache_modules  = $fcb_apache::apache_modules,
){

  class { 'apache':
#    default_vhost => false,
  }

  $vhosts.each |$vhost, $config| {

    if has_key($config, 'ssl') {
      $merged_ssl_config    = $vhosts_defaults['ssl'] + $config

      apache::vhost { "${vhost}":
        * => $merged_ssl_config,
      }
    }
    else {
      $merged_nonssl_config = $vhosts_defaults['nonssl'] + $config

      apache::vhost { "${vhost}":
        * => $merged_nonssl_config,
      }
    }
  }
  
  $apache_modules.each |$module| {
    apache::mod { $module: }
  }
}
