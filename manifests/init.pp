class fcb_apache {

  case $facts['os']['name'] {
    'RedHat', 'CentOS':  { include fcb_apache::linux }
    'Windows':           { include fcb_apache::windows }
  }
}
