# fcb_apache_v2

#### Table of Contents

1. [Overview](#overview)
1. [Module Description](#module-description)
1. [Setup](#setup)
1. [Usage](#usage)
1. [Hiera](#hiera)

## Overview

This module installs apache on Windows or Linux platforms.  The init.pp makes use of OS.Name fact to determine the install path.

## Module Description

This module is used to install Apache on both Windows and Linux platforms.  It uses dynamic hash ( * => $config ) to minimize updates needed for the wrapper module. 

There are 2 core yaml files used to configure Apache instances.  The merge stragey desired for this module is configured in the merge.yaml, and most effective way to set configuration in Hiera is a deep merge stategy to help minimize duplicate configuration.  For configuration items that apply to all systems or a majority of systems then defaults.yaml should be used for setting items in hiera.  If there is a need to override something in defaults then setting values in a more specific Hiera yaml will override anything in defaults.yaml based on a deep merge strategy.  The primary goal here is to minimize the number of places that things have to be configured in Hiera.  

### Linux 
The Apache forge module for the Linux installation.
```
https://forge.puppet.com/puppetlabs/apache
```

### Windows
The Windows installation makes use of custom install manifests as there was not an existing forge module for install Apache on Windows.

## Setup
```
puppet module install puppetlabs-apache --version 5.4.0
puppet module install puppetlabs-dsc --version 1.9.3
puppet module install puppetlabs-concat --version 6.2.0
puppet module install puppetlabs-powershell --version 2.3.0
```
## Usage
```
node default {
  include fcb_apache_v2
}
```

## Hiera
### Merge Strategy - merge.yaml
```
lookup_options:
  "fcb_apache_v2::.*":
    merge:                          # Merge the values found across hierarchies, instead of getting the first one
      strategy: deep                # Do a deep merge, useful when dealing with Hashes (to override single subkeys)
      merge_hash_arrays: true
```
### Linux Default - defaults.yaml
```
fcb_apache_v2::config:
  purge_configs: false
  default_vhost: false
fcb_apache_v2::purge_configs: false
fcb_apache_v2::packages:
  - mod_security
  - mod_security_crs
fcb_apache_v2::vhosts_defaults:
  nonssl:
    port: '8080'
    docroot: '/var/www/vhost'
  ssl:
    port: '443'
    ssl: true
    SSLEngine: on
    SSLCertificateFile: 'C:/apache.cer'
    SSLCertificateKeyFile: 'C:/apache.key'
    SSLCACertificateFile: 'C:/apache_root'
```
### Linux Vhost Example
The vhost is prepended to the 2 reserved words nonssl and ssl.  This ensures the proper merging of defaults in defaults.yaml.
```
fcb_apache_v2::modules:
  - status
fcb_apache_v2::vhosts:
  lark.fcb.com_nonssl:
    servername: 'lark.fcb.com'
    docroot: '/var/www/lark'
  lark.fcb.com_ssl:
    servername: 'lark.fcb.com'
    docroot: '/var/www/lark'
    ssl: true
```
### Windows Default - defaults.yaml
```
fcb_apache_v2::windows::version: '2.4.41'
fcb_apache_v2::windows::base_httpd_url: 'https://larkfileshare.blob.core.windows.net/fcb'
fcb_apache_v2::windows::vc_redist_exe: 'vc_redist.x64.exe'
fcb_apache_v2::windows::destination_path: 'c:/larktemp'
fcb_apache_v2::windows::install_path: 'c:/apache'
fcb_apache_v2::windows::apache_dir: 'Apache24'
fcb_apache_v2::windows::service_name: 'apache'
fcb_apache_v2::windows::state: 'running'
fcb_apache_v2::windows::registry_name: 'Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.23026'
fcb_apache_v2::windows::srvroot: '/Apache24'
fcb_apache_v2::windows::vhost_defaults:
  '80':
    DocumentRoot: 'c:/larktemp'
  '443':
    DocumentRoot: 'c:/larktemp'
    SSLEngine: 'On'
```
