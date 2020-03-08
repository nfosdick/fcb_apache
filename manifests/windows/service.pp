class fcb_apache_v2::windows::service {
  require fcb_apache_v2::windows::config

  $version          = $fcb_apache_v2::windows::version
  $install_path     = $fcb_apache_v2::windows::install_path
  $apche_dir        = $fcb_apache_v2::windows::apche_dir
  $service_name     = $fcb_apache_v2::windows::service_name
  $state            = $fcb_apache_v2::windows::state

  dsc_service{ $service_name:
    dsc_name  => "${service_name}",
    dsc_state => $state,
  }

  exec { 'Restart Apache':
    command     => "Restart-Service -Name $service_name",
    provider    => powershell,
    refreshonly => true,
    require     => Dsc_service[ $service_name ],
  }
}
