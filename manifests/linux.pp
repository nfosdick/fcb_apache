class fcb_apache::linux(
  $vhosts_defaults = $fcb_apache::vhosts_defaults, 
  $vhosts          = $fcb_apache::vhosts,
){

  class { 'apache':
#    default_vhost => false,
  }

  $vhosts.each |$vhost, $config| {
    notify{"Blah ${vhost}":}
    $merged_config = $vhosts_defaults['default_vhost_settings'] + $config
    #$merged_nonssl_config = $vhosts_defaults['vhost_nonssl'] + $config
    #$merged_ssl_config    = $vhosts_defaults['vhost_ssl'] + $config

    apache::vhost { "${vhost}":
      * => $merged_config,
    }
#
#    if has_key($config, 'ssl') {
#      apache::vhost { "${vhost}_ssl":
#        * => $merged_ssl_config,
#      }  
#    }
  }
}
