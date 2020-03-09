class fcb_apache_v2::windows::config {
  require fcb_apache_v2::windows::install

  # Get Core Variables
  $install_path   = $fcb_apache_v2::windows::install_path
  $apche_dir      = $fcb_apache_v2::windows::apche_dir
  $service_name   = $fcb_apache_v2::windows::service_name
  $config_file    = $fcb_apache_v2::windows::config_file
  $vhost          = $fcb_apache_v2::windows::vhost
  $vhost_defaults = $fcb_apache_v2::windows::vhost_defaults

  # Computed Variables
  $vhost_merged = $vhost_defaults['defaults'] + $vhost
  notify{ "Nick $vhost_merged":}

  Concat::Fragment {
    notify => Exec[ 'Restart Apache' ],
  }

  concat { "${$install_path}/${$apche_dir}/conf/httpd.conf":
    ensure => present,
    notify => Exec[ 'Restart Apache' ],
  }

  concat::fragment { 'httpd.conf':
    target  => "${$install_path}/${$apche_dir}/conf/httpd.conf",
    content => template("${module_name}/windows_httpd.conf.erb"),
    order   => '01',
  }

  # Template Doc:
  # https://stackoverflow.com/questions/7996695/what-is-the-difference-between-and-in-erb-in-rails
  concat::fragment { 'vhost':
    target  => "${$install_path}/${$apche_dir}/conf/httpd.conf",
    content => template("${module_name}/windows_vhost.erb"),
    order   => '10',
  }
}
