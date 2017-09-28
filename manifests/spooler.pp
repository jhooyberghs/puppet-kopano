# Class kopano::spooler
#
class kopano::spooler (
  String                    $run_user                       = 'kopano',
  String                    $run_group                      = 'kopano',
  String                    $package_name                   = 'kopano-spooler',
  String                    $service_name                   = 'kopano-spooler',
  String                    $package_version                = 'installed',
  Enum['running','stopped'] $service_ensure                 = 'running',
  Boolean                   $service_enable                 = true,
  String                    $smtp_server                    = 'localhost',
  Integer                   $smtp_port                      = 25,
  Enum['yes','no']          $coredump_enabled               = 'no',
  String                    $tmp_path                       = '/tmp',
  String                    $log_method                     = 'file',
  Stdlib::Absolutepath      $log_file                       = '/var/log/kopano/spooler.log',
  Integer[0,6]              $log_level                      = 3,
  Integer[0,1]              $log_timestamp                  = 1,
  Integer                   $max_threads                    = 5,
  String                    $fax_domain                     = 'fax.local',
  String                    $fax_international              = '00',
  Enum['yes','no']          $always_send_delegates          = 'no',
  Enum['yes','no']          $allow_redirect_spoofing        = 'yes',
  Enum['yes','no']          $copy_delegate_mails            = 'yes',
  Enum['yes','no']          $allow_delegate_meeting_request = 'yes',
  Enum['yes','no']          $allow_send_to_everyone         = 'yes',
  Enum['yes','no']          $always_send_tnef               = 'no',
  Enum['yes','no']          $always_send_utf8               = 'no',
  String                    $charset_upgrade                = 'windows-1252',
  Enum['yes','no']          $enable_dsn                     = 'yes',
  Enum['yes','no']          $expand_groups                  = 'no',
  Enum['yes','no']          $archive_on_send                = 'no',
  Enum['yes','no']          $plugin_enabled                 = 'yes',
  Stdlib::Absolutepath      $plugin_manager_path            = '/usr/share/kopano-spooler/python',
  Stdlib::Absolutepath      $plugin_path                    = '/var/lib/kopano/spooler/plugins',
) {
  package { $package_name:
    ensure => $package_version,
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

  file { '/etc/kopano/spooler.cfg':
    ensure  => file,
    mode    => '0640',
    owner   => $run_user,
    group   => $run_group,
    content => template('kopano/spooler.cfg.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
