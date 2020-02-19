class fcb_apache_v2::windows(
  $version          = '2.4.41',
  $architecture     = $facts['architecture'],
  $httpd_zip        = "httpd-${version}-win${architecture}-VS16.zip",
#  $url              = "http://www.apachelounge.com/download/VS16/binaries/${httpd_zip}",
  $url              = "https://send.firefox.com/download/7c843ee7605febd9/#D0Vbjr9iBMDsfzsRRaLQ7g",
  $destination_path = 'c:/larktemp',
  $zipfile          = "${destination_path}/${httpd_zip}",
){

  dsc_xremotefile {"Download ${httpd_zip}":
    dsc_destinationpath  => $zipfile,
    dsc_uri              => $url,
  }

  dsc_archive { "Unzip ${httpd_zip} and Copy the Content":
    dsc_ensure      => 'present',
    dsc_path        => $zipfile,
    dsc_destination => 'c:/nick',
  }
}
