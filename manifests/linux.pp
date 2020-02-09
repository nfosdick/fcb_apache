class fcb_apache::linux {

  class { 'apache':
    default_vhost => false,
  }
}
