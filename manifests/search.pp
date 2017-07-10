# Class kopano::search
#
class kopano::search (
  String                    $run_user                  = 'kopano',
  String                    $run_group                 = 'kopano',
  String                    $package_name              = 'kopano-search',
  String                    $service_name              = 'kopano-search',
  String                    $package_version           = 'installed',
  Enum['running','stopped'] $service_ensure            = 'running',
  Boolean                   $service_enable            = true,
  Stdlib::Absolutepath      $index_path                = '/var/lib/kopano/search/',
  Integer                   $limit_results             = 1000,
  String                    $server_bind_name          = 'file:///var/run/kopano/search.sock',
  Stdlib::Absolutepath      $ssl_private_key_file      = '/etc/kopano/search/privkey.pem',
  Stdlib::Absolutepath      $ssl_certificate_file      = '/etc/kopano/search/cert.pem',
  Enum['syslog','file']     $log_method                = 'file',
  Stdlib::Absolutepath      $log_file                  = '/var/log/kopano/search.log',
  Integer[0,1]              $log_timestamp             = 1,
  String                    $term_cache_size           = '64M',
  Integer                   $index_processes           = 1,
  Enum['no','yes']          $index_attachments         = 'no',
  String                    $index_attachment_max_size = '5M',
) {
  package { $package_name:
    ensure => $package_version,
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

  file { '/etc/kopano/search.cfg':
    ensure  => file,
    mode    => '0640',
    owner   => $run_user,
    group   => $run_group,
    content => template('kopano/search.cfg.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
