# Class kopano::gateway
#
class kopano::gateway (
  String                    $pop3_listen               = '*:110',
  String                    $pop3s_listen              = '',
  String                    $imap_listen               = '*:143',
  String                    $imaps_listen              = '',
  String                    $run_user                  = 'kopano',
  String                    $run_group                 = 'kopano',
  String                    $package_name              = 'kopano-gateway',
  String                    $service_name              = 'kopano-gateway',
  String                    $package_version           = 'installed',
  Enum['running','stopped'] $service_ensure            = 'running',
  Boolean                   $service_enable            = true,
  String                    $server_hostname           = $::fqdn,
  Enum['yes','no']          $server_hostname_greeting  = 'no',
  Enum['yes','no']          $coredump_enabled          = 'no',
  Enum['yes','no']          $imap_only_mailfolders     = 'yes',
  Enum['yes','no']          $imap_public_folders       = 'yes',
  Enum['yes','no']          $imap_capability_idle      = 'yes',
  String                    $imap_max_messagesize      = '128M',
  Enum['yes','no']          $imap_expunge_on_delete    = 'no',
  Integer                   $imap_max_fail_commands    = 10,
  Enum['yes','no']          $disable_plaintext_auth    = 'no',
  Stdlib::Absolutepath      $ssl_private_key_file      = '/etc/kopano/gateway/privkey.pem',
  Stdlib::Absolutepath      $ssl_certificate_file      = '/etc/kopano/gateway/cert.pem',
  Enum['yes','no']          $ssl_verify_client         = 'no',
  String                    $ssl_verify_file           = '',
  String                    $ssl_verify_path           = '',
  String                    $ssl_protocols             = '!SSLv2 !SSLv3',
  String                    $ssl_ciphers               = 'ALL:!LOW:!SSLv2:!EXP:!aNULL',
  Enum['yes','no']          $ssl_prefer_server_ciphers = 'no',
  String                    $process_model             = 'fork',
  Stdlib::Absolutepath      $tmp_path                  = '/tmp',
  Enum['file','syslog']     $log_method                = 'file',
  Stdlib::Absolutepath      $log_file                  = '/var/log/kopano/gateway.log',
  Integer[0,6]              $log_level                 = 3,
  Integer[0,1]              $log_timestamp             = 1,
) {
  package { $package_name:
    ensure => $package_version,
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

  file { '/etc/kopano/gateway.cfg':
    ensure  => file,
    mode    => '0640',
    owner   => $run_user,
    group   => $run_group,
    content => template('kopano/gateway.cfg.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
