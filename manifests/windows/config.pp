class fcb_apache_v2::windows::config {
  require fcb_apache_v2::windows::install

  $install_path     = "c:"
  $apche_dir        = "Apache24"
  $service_name     = 'apache"

  file { "${$install_path}/${$apche_dir}/conf/httpd.conf":
    ensure  => file,
    content => template("${module_name}/windows_httpd.conf.erb"),
#    notify  => Dsc_service[ $service_name ],
  }

}
