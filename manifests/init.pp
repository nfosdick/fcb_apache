class fcb_apache(
  $config,
  $vhosts,
  $vhosts_defaults,
  $modules,
  $packages,
){

  case $facts['os']['name'] {
    'RedHat', 'CentOS':  { include fcb_apache::linux }
    'Windows':           { include fcb_apache::windows }
  }
}
