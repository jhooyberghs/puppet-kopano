# Class kopano::ical
#
class kopano::ical (
  String                    $run_user                  = 'kopano',
  String                    $run_group                 = 'kopano',
  String                    $package_name              = 'kopano-ical',
  String                    $service_name              = 'kopano-ical',
  String                    $package_version           = 'installed',
  Enum['running','stopped'] $service_ensure            = 'running',
  Boolean                   $service_enable            = true,
  Enum['yes','no']          $ical_enable               = 'yes',
  Integer                   $ical_port                 = 8080,
  Enum['yes','no']          $icals_enable              = 'no',
  Integer                   $icals_port                = 8443,
  String                    $server_socket             = 'http://localhost:236/',
  Enum['thread','fork']     $process_model             = 'fork',
  String                    $log_method                = 'file',
  Stdlib::Absolutepath      $log_file                  = '/var/log/kopano/ical.log',
  Integer[0,1]              $log_timestamp             = 1,
  Stdlib::Absolutepath      $ssl_private_key_file      = '/etc/kopano/ical/privkey.pem',
  Stdlib::Absolutepath      $ssl_certificate_file      = '/etc/kopano/ical/cert.pem',
  Enum['yes','no']          $ssl_verify_client         = 'no',
  String                    $ssl_verify_file           = '',
  String                    $ssl_verify_path           = '',
  String                    $ssl_ciphers               = 'ALL:!LOW:!SSLv2:!EXP:!aNULL',
  Enum['yes','no']          $ssl_prefer_server_ciphers = 'no',
  String                    $server_timezone           = 'Europe/Amsterdam',
  String                    $default_charset           = 'utf-8',
  Enum['yes','no']          $enable_ical_get           = 'yes',
) {
  package { $package_name:
    ensure => $package_version,
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

  file { '/etc/kopano/ical.cfg':
    ensure  => file,
    mode    => '0640',
    owner   => $run_user,
    group   => $run_group,
    content => template('kopano/ical.cfg.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
