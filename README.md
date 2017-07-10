#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with kopano](#setup)
    * [What kopano affects](#what-kopano-affects)
    * [What the module needs](#prerequisites)
    * [Start using the module, the basics](#start-using-the-kopano-module)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Overview

This module will install and configure Kopano with puppet. Kopano is an open-source communication stack, forked from the previously existing Zarafa.

## Setup

### What kopano affects

* The module will manage the installation of the Kopano packages, services and the configuration files in /etc/kopano.

### Prerequisites

The module expects kopano packages to be available to the server entitled with these classes.

### Start using the kopano module

To have Puppet install Kopano with the default parameters, declare the kopano class

``` puppet
class { 'kopano': }
```

The puppet module with install, configure and enable all of the currently supported daemons. The list of daemons is available in manifests/init.pp.

### Usage
You can choose to disable one or more services to be installed and configured by setting it's enabled param to false.

``` puppet
class { 'kopano':
  enable_ical => false,
}
```

It's also possible to combine the individual classes to the setup you prefer.

``` puppet
class { 'kopano::server':
	mysql_host 		=> 'mysql.example.com',
    mysql_password 	=> 'SuP3rS3cret'
}

class { 'kopano::gateway':
	pop3_enable  => 'no',
    imaps_enable => 'yes',
}
```

For configuring the different components, all supported config file options should be available. You can ofcourse also change the way the server is configured by setting it's hiera values.

``` yaml
---
kopano::server::log_method: syslog
kopano::server::mysql_host: mysql.example.com
kopano::server::mysql_password: SuP3rS3cret
kopano::server::disabled_features:
  - imap
  - pop3
  - outlook
  - mobile

```

## Limitations

* This module is currently only tested on Centos 7.
* It's ready for using the kopano db user_plugin or unix, but not yet for ldap, ldapms.

## Development

Pull requests very welcome!

If you tested this module on different a different OS, or need some changes to make it fit, please submit a Pull Request to get your changes merged. If you don't know how to fix something or are stuck looking for a solutions, feel free to open an issue and get in contacti.

