# Class kopano::monitor
#
class kopano::monitor (
  String                    $run_user                      = 'kopano',
  String                    $run_group                     = 'kopano',
  String                    $package_name                  = 'kopano-monitor',
  String                    $service_name                  = 'kopano-monitor',
  String                    $package_version               = 'installed',
  Enum['running','stopped'] $service_ensure                = 'running',
  Boolean                   $service_enable                = true,
  String                    $servers                       = '',
  Enum['file','syslog']     $log_method                    = 'file',
  Stdlib::Absolutepath      $log_file                      = '/var/log/kopano/monitor.log',
  Integer[0,6]              $log_level                     = 3,
  Integer[0,1]              $log_timestamp                 = 1,
  Integer                   $quota_check_interval          = 15,
  Integer                   $mailquota_resend_interval     = 1,
  Stdlib::Absolutepath      $userquota_warning_template    = '/etc/kopano/quotamail/userwarning.mail',
  Stdlib::Absolutepath      $companyquota_warning_template = '/etc/kopano/quotamail/companywarning.mail',
) {
  package { $package_name:
    ensure => $package_version,
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

  file { '/etc/kopano/monitor.cfg':
    ensure  => file,
    mode    => '0640',
    owner   => $run_user,
    group   => $run_group,
    content => template('kopano/monitor.cfg.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
