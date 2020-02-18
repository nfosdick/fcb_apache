class fcb_apache_v2::linux(
  $config          = $fcb_apache_v2::config,
  $vhosts_defaults = $fcb_apache_v2::vhosts_defaults, 
  $vhosts          = $fcb_apache_v2::vhosts,
  $modules         = $fcb_apache_v2::modules,
  $packages        = $fcb_apache_v2::packages,
){
  # Core Apache Module
  class { 'apache':
    * => $config,
  }

  # Create Vhosts
  $vhosts.each |$vhost, $config| {

    if has_key($config, 'ssl') {
      $merged_ssl_config    = $vhosts_defaults['ssl'] + $config

      apache::vhost { "${vhost}":
        * => $merged_ssl_config,
      }
    }
    else {
      $merged_nonssl_config = $vhosts_defaults['nonssl'] + $config

      apache::vhost { "${vhost}":
        * => $merged_nonssl_config,
      }
    }
  }
  
  $modules.each |$index, $module| {
    apache::mod { $module: }
  }

  $packages.each |$index, $package| {
    package{ $package: 
      notify => Package[ 'httpd' ],
    }
  }
}
