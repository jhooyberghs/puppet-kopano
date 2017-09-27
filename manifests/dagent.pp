# Class kopano::dagent
#
class kopano::dagent (
  String                    $run_user             = 'kopano',
  String                    $run_group            = 'kopano',
  String                    $package_name         = 'kopano-dagent',
  String                    $service_name         = 'kopano-dagent',
  String                    $package_version      = 'installed',
  Enum['running','stopped'] $service_ensure       = 'running',
  Boolean                   $service_enable       = true,
  Enum['file','syslog']     $log_method           = 'file',
  Stdlib::Absolutepath      $log_file             = '/var/log/kopano/dagent.log',
  Integer[0,6]              $log_level            = 3,
  Enum['0','1']             $log_timestamp        = '1',
  Enum['yes','no']          $log_raw_message      = 'no',
  Stdlib::Absolutepath      $log_raw_message_path = '/tmp',
  Stdlib::Absolutepath      $tmp_path             = '/tmp',
  Integer                   $lmtp_port            = 2003,
  Integer                   $lmtp_max_threads     = 20,
  Enum['yes','no']          $coredump_enabled     = 'no',
  String                    $spam_header_name     = 'X-Spam-Status',
  String                    $spam_header_value    = 'Yes',
  Enum['yes','no']          $archive_on_delivery  = 'no',
  Enum['yes','no']          $plugin_enabled       = 'yes',
  Stdlib::Absolutepath      $plugin_manager_path  = '/usr/share/kopano-dagent/python',
  Stdlib::Absolutepath      $plugin_path          = '/var/lib/kopano/dagent/plugins',
  Enum['yes','no']          $set_rule_headers     = 'yes',
  Enum['yes','no']          $no_double_forward    = 'no',
) {
  package { $package_name:
    ensure => $package_version,
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

  file { '/etc/kopano/dagent.cfg':
    ensure  => file,
    mode    => '0640',
    owner   => $run_user,
    group   => $run_group,
    content => template('kopano/dagent.cfg.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
