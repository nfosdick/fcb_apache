class fcb_apache::linux(
  $vhosts_defaults = $fcb_apache::vhosts_defaults, 
  $vhosts          = $fcb_apache::vhosts,
){

  class { 'apache':
#    default_vhost => false,
  }

  $vhosts.each |$vhost, $config| {
    $merged_config = $vhosts_defaults['vhost_nonssl'] + $config
    apache::vhost { "${vhost}_nonssl":
      servername => $vhost,
      *          => $merged_config,
    }
  }
}
