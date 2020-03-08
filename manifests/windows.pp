class fcb_apache_v2::windows(
  $version          = '2.4.41',
  $architecture     = $facts['architecture'],
  $httpd_zip        = "httpd-${version}-o111c-${architecture}-vc15-r2.zip",
  $httpd_url        = "https://larkfileshare.blob.core.windows.net/fcb/${httpd_zip}",
  $vc_redist_exe    = 'vc_redist.x64.exe',
  $vc_redist_url    = "https://larkfileshare.blob.core.windows.net/fcb/${vc_redist_exe}",
  $destination_path = 'c:/larktemp',
  $zipfile          = "${destination_path}/${httpd_zip}",
  $exe_file         = "${destination_path}/${vc_redist_exe}",
  $install_path     = "c:",
  $apche_dir        = "Apache24",
  $service_name     = 'apache',
  $state            = 'running',
  $registry_name    = 'Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.23026',
  $vhost            = {},
){

  include fcb_apache_v2::windows::install

#  #$httpd_url "https://www.apachehaus.com/downloads/${httpd_zip}",
#  dsc_xremotefile {"Download ${httpd_zip}":
#   dsc_destinationpath  => $zipfile,
#   dsc_uri              => $httpd_url,
# }
#
#  dsc_xremotefile {"Download ${vc_redist_exe}":
#   dsc_destinationpath  => $exe_file,
#   dsc_uri              => $vc_redist_url,
#   before               => Dsc_service[ $service_name ],
# }
#
#  # https://community.spiceworks.com/topic/2138691-installing-visual-c-silently-using-powershell
#  # c:\larktemp\vc_redist.x64.exe /q /norestart -Wait
#  # https://docs.microsoft.com/en-us/archive/blogs/astebner/mailbag-how-to-perform-a-silent-install-of-the-visual-c-2010-redistributable-packages
#  package { $registry_name:
#    ensure          => installed,
#    source          => "${destination_path}/${vc_redist_exe}",
#    install_options => ['/q', '/norestart', '-Wait'],
#    require         => Dsc_xremotefile[ "Download ${vc_redist_exe}" ],
#  }
#
#  dsc_archive { "Unzip ${httpd_zip} and Copy the Content":
#    dsc_ensure      => 'present',
#    dsc_path        => $zipfile,
#    dsc_destination => $install_path,
#    require         => Dsc_xremotefile[ "Download ${httpd_zip}" ],
#  }
#
#  # https://httpd.apache.org/docs/2.4/platform/windows.html
#  # Remove:  ./httpd.exe -k uninstall -n "apache"
#  exec { "Install apache-${version} Windows Service":
#    command  => "${install_path}/${apche_dir}/bin/httpd.exe -k install -n \"${service_name}\"",
#    unless   => "if(Get-Service ${service_name}){ exit 0 }else{ exit 1 }",
#    provider => powershell,
#    require  => Dsc_archive[ "Unzip ${httpd_zip} and Copy the Content" ],
#  }
#
#  file { "${$install_path}/${$apche_dir}/conf/httpd.conf":
#    ensure  => file,
#    content => template("${module_name}/windows_httpd.conf.erb"),
#    notify  => Dsc_service[ $service_name ],
#  }
#
#  dsc_service{ $service_name:
#    dsc_name  => "${service_name}",
#    dsc_state => $state,
#    require   => Exec[ "Install apache-${version} Windows Service" ],
#  }
#
#  exec { 'Restart Apache':
#    command     => "Restart-Service -Name $service_name",
#    provider    => powershell,
#    refreshonly => true,
#    subscribe   => File[ "${$install_path}/${$apche_dir}/conf/httpd.conf" ],
#    require     => Dsc_service[ $service_name ],
#  }
}
