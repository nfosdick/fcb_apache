# fcb_apache_v2

#### Table of Contents

1. [Overview](#overview)
1. [Module Description](#module-description)
1. [Setup](#setup)
1. [Usage](#usage)
1. [Hiera](#hiera)

## Overview

This module installs apache on Windows or Linux platforms.  

## Module Description

This module is used to install Apache on both Windows and Linux platforms.  

### Linux 
The Apache forge module for the Linux installation.

### Windows
Windows 

## Setup
puppet module install puppetlabs-apache --version 5.4.0
puppet module install puppetlabs-dsc --version 1.9.3
puppet module install puppetlabs-concat --version 6.2.0
puppet module install puppetlabs-powershell --version 2.3.0

## Usage
```
node default {
  include fcb_apache_v2
}
```

## Hiera
### Linux Default
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
### Windows Default
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
