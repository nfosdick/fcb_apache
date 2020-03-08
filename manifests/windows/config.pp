class fcb_apache_v2::windows::config {
  require fcb_apache_v2::windows::install

  $install_path     = $fcb_apache_v2::windows::install_path
  $apche_dir        = $fcb_apache_v2::windows::apche_dir
  $service_name     = $fcb_apache_v2::windows::service_name

  file { "${$install_path}/${$apche_dir}/conf/httpd.conf":
    ensure  => file,
    content => template("${module_name}/windows_httpd.conf.erb"),
#    notify  => Dsc_service[ $service_name ],
  }

}
