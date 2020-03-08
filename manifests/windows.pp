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
  include fcb_apache_v2::windows::config
  include fcb_apache_v2::windows::service
}
