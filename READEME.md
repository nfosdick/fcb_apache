# fcb_apache_v2

#### Table of Contents

1. [Overview](#overview)
1. [Module Description](#module-description)
1. [Setup](#setup)
1. [Usage](#usage)
1. [Hiera](#hiera)
1. [Reference](#reference)
    1. [Data Types](#data-types)
    1. [Facts](#facts)
1. [Limitations](#limitations)
1. [Development](#development)
1. [Contributors](#contributors)

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
#  default_vhost: false
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
fcb_apache_v2::vhosts:
  lark.fcb.com_nonssl:
    servername: 'lark.fcb.com'
    docroot: '/var/www/lark'
  lark.fcb.com_ssl:
    servername: 'lark.fcb.com'
    docroot: '/var/www/lark'
    ssl: true
fcb_apache_v2::modules:
  - status
```
