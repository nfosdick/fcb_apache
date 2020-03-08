class fcb_apache_v2::windows::config {
  require fcb_apache_v2::windows::install

  $install_path = $fcb_apache_v2::windows::install_path
  $apche_dir    = $fcb_apache_v2::windows::apche_dir
  $service_name = $fcb_apache_v2::windows::service_name
  $config_file  = $fcb_apache_v2::windows::config_file
  $vhost        = $fcb_apache_v2::windows::vhost

  concat { "${$install_path}/${$apche_dir}/conf/httpd.conf":
    ensure => present,
  }

  concat::fragment { 'tmpfile':
    target  => "${$install_path}/${$apche_dir}/conf/httpd.conf",
    content => template("${module_name}/windows_httpd.conf.erb"),
    order   => '01',
    notify  => Exec[ 'Restart Apache' ],
  }
}
