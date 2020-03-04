class fcb_apache_v2::windows(
  $version          = '2.4.41',
  $architecture     = $facts['architecture'],
  $httpd_zip        = "httpd-${version}-o111c-${architecture}-vc15-r2.zip",
  $url              = "https://www.apachehaus.com/downloads/${httpd_zip}",
  $destination_path = 'c:/larktemp',
  $zipfile          = "${destination_path}/${httpd_zip}",
  $install_path     = "c:/",
  $apche_dir        = "Apache24",
  $service_name     = 'apache',
){

#  notify{"Lark $url":}
#  dsc_xremotefile {"Download ${httpd_zip}":
#   dsc_destinationpath  => $zipfile,
#   dsc_uri              => $url,
# }

  dsc_archive { "Unzip ${httpd_zip} and Copy the Content":
    dsc_ensure      => 'present',
    dsc_path        => $zipfile,
    dsc_destination => $install_path,
#    require         => Dsc_xremotefile[ "Download ${httpd_zip}" ],
  }

  # https://httpd.apache.org/docs/2.4/platform/windows.html
  # Remove:  ./httpd.exe -k uninstall -n "apache"
  exec { "Install apache-${version} Windows Service":
    command   => "${install_path}/${apche_dir}/bin/httpd.exe -k install -n \"${service_name}\"",
    unless    => "if(Get-Service ${service_name}){ exit 0 }else{ exit 1 }",
    provider  => powershell,
    require   => Dsc_archive[ "Unzip ${httpd_zip} and Copy the Content" ],
  }

  dsc_service{ $service_name:
    dsc_name  => "${service_name}",
    dsc_state => 'running',
    require   => Exec[ "Install apache-${version} Windows Service" ],
  }
}
