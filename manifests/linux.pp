class fcb_apache::linux(
  $vhosts = $fcb_apache::vhosts,
){

  class { 'apache':
#    default_vhost => false,
  }

  $vhosts.each |$vhost, $config| {
    apache::vhost { $vhost:
      * => $config,
    }
  }
}
