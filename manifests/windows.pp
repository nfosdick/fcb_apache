class fcb_apache_v2::windows(
  $version            = '2.4.41',
  $architecture       = $facts['architecture'],
  $base_httpd_url     = 'https://larkfileshare.blob.core.windows.net/fcb',
  $httpd_zip          = "httpd-${version}-o111c-${architecture}-vc15-r2.zip",
  $vc_redist_exe      = 'vc_redist.x64.exe',
  $destination_path   = 'c:/larktemp',
  $install_path       = "c:",
  $apache_dir         = "Apache24",
  $service_name       = 'apache',
  $state              = 'running',
  $registry_name      = 'Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.23026',
  $vhost              = {},
  $vhost_defaults,
){

  # Computed Variables
  $httpd_url     = "${base_httpd_url}/${httpd_zip}"
  $vc_redist_url = "${base_httpd_url}/${vc_redist_exe}"
  $zipfile       = "${destination_path}/${httpd_zip}"
  $exe_file      = "${destination_path}/${vc_redist_exe}"
  $config_file   = "${$install_path}/${$apche_dir}/conf/httpd.conf"

  # Class Includes
  include fcb_apache_v2::windows::install
  include fcb_apache_v2::windows::config
  include fcb_apache_v2::windows::service
}
