class fcb_apache_v2::windows::config {
  require fcb_apache_v2::windows::install

  # Get Core Variables
  $install_path             = $fcb_apache_v2::windows::install_path
  $apache_dir               = $fcb_apache_v2::windows::apache_dir
  $srvroot                  = $fcb_apache_v2::windows::srvroot
  $service_name             = $fcb_apache_v2::windows::service_name
  $default_modules          = $fcb_apache_v2::windows::default_modules
  $modules                  = $fcb_apache_v2::windows::modules
  $config_file              = $fcb_apache_v2::windows::config_file
  $vhosts                   = $fcb_apache_v2::windows::vhosts
  $vhost_defaults           = $fcb_apache_v2::windows::vhost_defaults
  $vhost_directory_defaults = $fcb_apache_v2::windows::vhost_directory_defaults

  $merged_modules = $default_modules + $modules

  Concat::Fragment {
    notify => Exec[ 'Restart Apache' ],
  }

  concat { "${$install_path}/${$apache_dir}/conf/httpd.conf":
    ensure => present,
    notify => Exec[ 'Restart Apache' ],
  }

  concat::fragment { 'httpd.conf':
    target  => "${$install_path}/${$apache_dir}/conf/httpd.conf",
    content => template("${module_name}/windows_httpd.conf.erb"),
    order   => '01',
  }

  # Template Doc:
  # https://stackoverflow.com/questions/7996695/what-is-the-difference-between-and-in-erb-in-rails
  concat::fragment { 'vhost':
    target  => "${$install_path}/${$apache_dir}/conf/httpd.conf",
    content => template("${module_name}/windows_vhost.erb"),
    order   => '10',
  }
}
