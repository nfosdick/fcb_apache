class fcb_apache_v2::windows(
  $version         = '2.4.41',
  $architecture    = $facts['architecture'],
  $httpd_zip       = "httpd-${version}-win${architecture}-VS16.zip",
  $url             = "https://www.apachelounge.com/download/VS16/binaries/${httpd_zip}",
  destination_path = 'c:/larktemp',
){

  dsc_xremotefile {"Download ${httpd_zip}":
    dsc_destinationpath => "${destination_path}/${httpd_zip}"",
    dsc_uri             => $url,
  }
  #https://www.apachelounge.com/download/VS16/binaries/httpd-2.4.41-win64-VS16.zip
}
