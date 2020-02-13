class fcb_apache(
  $vhosts,
  $vhosts_defaults,
  $modules,
  $purge_configs,
){

  case $facts['os']['name'] {
    'RedHat', 'CentOS':  { include fcb_apache::linux }
    'Windows':           { include fcb_apache::windows }
  }
}
