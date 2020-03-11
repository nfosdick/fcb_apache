class fcb_apache_v2::windows(
  $architecture = $facts['architecture'],
  $httpd_zip    = "httpd-${version}-o111c-${architecture}-vc15-r2.zip",
  $vhosts       = {},
  $version,
  $base_httpd_url,
  $vc_redist_exe,
  $destination_path,
  $install_path,
  $apache_dir,
  $service_name,
  $state,
  $registry_name,
  $vhost_defaults,
  $vhost_directory_defaults,
){

  # Computed Variables
  $httpd_url     = "${base_httpd_url}/${httpd_zip}"
  $vc_redist_url = "${base_httpd_url}/${vc_redist_exe}"
  $zipfile       = "${destination_path}/${httpd_zip}"
  $exe_file      = "${destination_path}/${vc_redist_exe}"
  $config_file   = "${$install_path}/${$apache_dir}/conf/httpd.conf"

  # Class Includes
  include fcb_apache_v2::windows::install
#  include fcb_apache_v2::windows::config
#  include fcb_apache_v2::windows::service
}
