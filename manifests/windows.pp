class fcb_apache_v2::windows(
  $version          = '2.4.41',
  $architecture     = $facts['architecture'],
  $httpd_zip        = "httpd-${version}-win${architecture}-VS16.zip",
#  $url              = "http://www.apachelounge.com/download/VS16/binaries/${httpd_zip}",
  $url              = "https://send.firefox.com/download/c9d0054c9be88acc/#1U2sCaJBd-VZiMs-g5kovg",
  $destination_path = 'c:/larktemp',
){
#  notify{"Nick  $url, ${destination_path}/${httpd_zip}":}
  dsc_xremotefile {"Download ${httpd_zip}":
    dsc_destinationpath  => "${destination_path}/${httpd_zip}",
#    dsc_destinationpath => 'c:/larktemp/httpd-2.4.41-winx64-VS16.zip',
    dsc_uri              => $url,
  }
  #https://www.apachelounge.com/download/VS16/binaries/httpd-2.4.41-win64-VS16.zip
}
