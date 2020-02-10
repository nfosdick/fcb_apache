class fcb_apache(
  $vhosts,
  $vhosts_defaults,
  $modules,
){

  case $facts['os']['name'] {
    'RedHat', 'CentOS':  { include fcb_apache::linux }
    'Windows':           { include fcb_apache::windows }
  }
}
