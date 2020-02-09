class fcb_apache::linux(
  $vhosts_defaults = $fcb_apache::vhosts_defaults, 
  $vhosts          = $fcb_apache::vhosts,
){

  class { 'apache':
#    default_vhost => false,
  }

  $vhosts.each |$vhost, $config| {

    if has_key($config, 'ssl') {
      $merged_ssl_config    = $vhosts_defaults['vhost_ssl'] + $config

      apache::vhost { "${vhost}":
        * => $merged_ssl_config,
      }
    }
    else {
      $merged_nonssl_config = $vhosts_defaults['vhost_nonssl'] + $config

      apache::vhost { "${vhost}":
        * => $merged_nonssl_config,
      }
    }
  }
}
