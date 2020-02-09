class fcb_apache::linux(
  $vhosts_defaults, 
  $vhosts = $fcb_apache::vhosts,
){

  class { 'apache':
#    default_vhost => false,
  }

  $vhosts.each |$vhost, $config| {
    $merged_config = $vhosts_defaults + $config
    apache::vhost { $vhost:
      * => $merged_config,
    }
  }
}
