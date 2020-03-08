class fcb_apache_v2::windows::install {
  $version          = $fcb_apache_v2::windows::version
  $architecture     = $fcb_apache_v2::windows::architecture
  $httpd_zip        = $fcb_apache_v2::windows::httpd_zip
  $httpd_url        = $fcb_apache_v2::windows::httpd_url
  $vc_redist_exe    = $fcb_apache_v2::windows::vc_redist_exe
  $vc_redist_url    = $fcb_apache_v2::windows::vc_redist_url
  $destination_path = $fcb_apache_v2::windows::destination_path
  $zipfile          = $fcb_apache_v2::windows::zipfile
  $exe_file         = $fcb_apache_v2::windows::exe_file
  $install_path     = $fcb_apache_v2::windows::install_path
  $apche_dir        = $fcb_apache_v2::windows::apche_dir
  $registry_name    = $fcb_apache_v2::windows::registry_name

  #$httpd_url "https://www.apachehaus.com/downloads/${httpd_zip}",
  dsc_xremotefile {"Download ${httpd_zip}":
   dsc_destinationpath  => $zipfile,
   dsc_uri              => $httpd_url,
 }

  dsc_xremotefile {"Download ${vc_redist_exe}":
   dsc_destinationpath  => $exe_file,
   dsc_uri              => $vc_redist_url,
 }

  # https://community.spiceworks.com/topic/2138691-installing-visual-c-silently-using-powershell
  # c:\larktemp\vc_redist.x64.exe /q /norestart -Wait
  # https://docs.microsoft.com/en-us/archive/blogs/astebner/mailbag-how-to-perform-a-silent-install-of-the-visual-c-2010-redistributable-packages
  package { $registry_name:
    ensure          => installed,
    source          => "${destination_path}/${vc_redist_exe}",
    install_options => ['/q', '/norestart', '-Wait'],
    require         => Dsc_xremotefile[ "Download ${vc_redist_exe}" ],
  }

  dsc_archive { "Unzip ${httpd_zip} and Copy the Content":
    dsc_ensure      => 'present',
    dsc_path        => $zipfile,
    dsc_destination => $install_path,
    require         => Dsc_xremotefile[ "Download ${httpd_zip}" ],
  }

  # https://httpd.apache.org/docs/2.4/platform/windows.html
  # Remove:  ./httpd.exe -k uninstall -n "apache"
  exec { "Install apache-${version} Windows Service":
    command  => "${install_path}/${apche_dir}/bin/httpd.exe -k install -n \"${service_name}\"",
    unless   => "if(Get-Service ${service_name}){ exit 0 }else{ exit 1 }",
    provider => powershell,
    require  => Dsc_archive[ "Unzip ${httpd_zip} and Copy the Content" ],
  }
}
