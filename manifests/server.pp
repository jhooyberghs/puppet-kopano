# Class kopano::server
#
class kopano::server (
  String                                        $package_name                     = 'kopano-server',
  String                                        $service_name                     = 'kopano-server',
  String                                        $package_version                  = 'installed',
  Enum['running','stopped']                     $service_ensure                   = 'running',
  Boolean                                       $service_enable                   = true,
  String                                        $server_listen                    = '*:236',
  Stdlib::Absolutepath                          $server_pipe_name                 = '/var/run/kopano/server.sock',
  Stdlib::Absolutepath                          $server_pipe_priority             = '/var/run/kopano/prio.sock',
  String                                        $server_name                      = 'Kopano',
  String                                        $server_hostname                  = $::fqdn,
  String                                        $database_engine                  = 'mysql',
  Enum['yes','no']                              $allow_local_users                = 'yes',
  Array[String]                                 $local_admin_users                = [ 'root', 'kopano' ],
  Boolean                                       $owner_auto_full_access           = true,
  String                                        $system_email_address             = "postmaster@${::domain}",
  String                                        $run_as_user                      = 'root',
  String                                        $run_as_group                     = 'root',
  Stdlib::Absolutepath                          $pid_file                         = '/var/run/kopano/server.pid',
  String                                        $allocator_library                = 'default',
  Enum['yes','no']                              $coredump_enabled                 = 'yes',
  Integer                                       $session_timeout                  = 300,
  String                                        $tmp_path                         = '/tmp',
  Enum['file','syslog']                         $log_method                       = 'file',
  Stdlib::Absolutepath                          $log_file                         = '/var/log/kopano/server.log',
  Integer[0,6]                                  $log_level                        = 3,
  Integer[0,1]                                  $log_timestamp                    = 1,
  Integer                                       $log_buffer_size                  = 0,
  Enum['yes','no']                              $audit_log_enabled                = 'no',
  Enum['file','syslog']                         $audit_log_method                 = 'syslog',
  Stdlib::Absolutepath                          $audit_log_file                   = '/var/log/kopano/audit.log',
  Integer[0,1]                                  $audit_log_level                  = 1,
  Integer[0,1]                                  $audit_log_timestamp              = 1,
  String                                        $mysql_host                       = 'localhost',
  Integer                                       $mysql_port                       = 3306,
  String                                        $mysql_user                       = 'root',
  String                                        $mysql_password                   = '',
  String                                        $mysql_socket                     = '',
  String                                        $mysql_database                   = 'kopano',
  String                                        $mysql_engine                     = 'InnoDB',
  Enum['database','files','s3']                 $attachment_storage               = 'files',
  Enum['yes','no']                              $attachment_files_fsync           = 'yes',
  Stdlib::Absolutepath                          $attachment_path                  = '/var/lib/kopano/attachments',
  Integer                                       $attachment_compression           = 6,
  String                                        $attachment_s3_hostname           = '',
  String                                        $attachment_s3_region             = '',
  Enum['http','https']                          $attachment_s3_protocol           = 'https',
  Enum['virtualhost','path']                    $attachment_s3_uristyle           = 'virtualhost',
  String                                        $attachment_s3_accesskeyid        = '',
  String                                        $attachment_s3_secretaccesskey    = '',
  String                                        $attachment_s3_bucketname         = '',
  String                                        $server_listen_tls                = '',
  Stdlib::Absolutepath                          $server_ssl_key_file              = '/etc/kopano/ssl/server.pem',
  String                                        $server_ssl_key_pass              = 'replace-with-server-cert-password',
  Stdlib::Absolutepath                          $server_ssl_ca_file               = '/etc/kopano/ssl/cacert.pem',
  String                                        $server_ssl_ca_path               = '',
  String                                        $server_ssl_protocols             = '',
  String                                        $server_ssl_ciphers               = 'ALL:!LOW:!SSLv2:!EXP:!aNULL',
  Enum['yes','no']                              $server_ssl_prefer_server_ciphers = 'no',
  Stdlib::Absolutepath                          $sslkeys_path                     = '/etc/kopano/sslkeys',
  Integer                                       $threads                          = 8,
  Integer                                       $watchdog_frequency               = 1,
  Integer                                       $watchdog_max_age                 = 500,
  Integer                                       $server_recv_timeout              = 5,
  Integer                                       $server_read_timeout              = 60,
  Integer                                       $server_send_timeout              = 60,
  Integer                                       $softdelete_lifetime              = 30,
  Integer                                       $sync_lifetime                    = 90,
  Enum['yes','no']                              $enable_sso                       = 'no',
  Enum['yes','no']                              $enable_gab                       = 'yes',
  String                                        $auth_method                      = 'plugin',
  String                                        $pam_service                      = 'passwd',
  String                                        $cache_cell_size                  = '256M',
  String                                        $cache_quota_size                 = '1M',
  Integer                                       $cache_quota_lifetime             = 1,
  String                                        $cache_acl_size                   = '1M',
  String                                        $cache_store_size                 = '1M',
  String                                        $cache_user_size                  = '1M',
  String                                        $cache_userdetails_size           = '25M',
  Integer                                       $cache_userdetails_lifetime       = 0,
  String                                        $cache_server_size                = '1M',
  Integer                                       $cache_server_lifetime            = 30,
  Integer                                       $quota_warn                       = 0,
  Integer                                       $quota_soft                       = 0,
  Integer                                       $quota_hard                       = 0,
  Integer                                       $companyquota_warn                = 0,
  Enum['ldap','unix','db','ldapms']             $user_plugin                      = 'db',
  Stdlib::Absolutepath                          $user_plugin_config               = '/etc/kopano/ldap.cfg',
  Stdlib::Absolutepath                          $createuser_script                = '/etc/kopano/userscripts/createuser',
  Stdlib::Absolutepath                          $deleteuser_script                = '/etc/kopano/userscripts/deleteuser',
  Stdlib::Absolutepath                          $creategroup_script               = '/etc/kopano/userscripts/creategroup',
  Stdlib::Absolutepath                          $deletegroup_script               = '/etc/kopano/userscripts/deletegroup',
  Stdlib::Absolutepath                          $createcompany_script             = '/etc/kopano/userscripts/createcompany',
  Stdlib::Absolutepath                          $deletecompany_script             = '/etc/kopano/userscripts/deletecompany',
  Enum['yes','no']                              $user_safe_mode                   = 'no',
  Integer                                       $thread_stacksize                 = 512,
  Boolean                                       $enable_hosted_kopano             = false,
  Boolean                                       $enable_distributed_kopano        = false,
  String                                        $storename_format                 = '%f',
  String                                        $loginname_format                 = '%u',
  Boolean                                       $client_update_enabled            = false,
  Stdlib::Absolutepath                          $client_update_path               = '/var/lib/kopano/client',
  Integer[0,2]                                  $client_update_log_level          = 1,
  Stdlib::Absolutepath                          $client_update_log_path           = '/var/log/kopano/autoupdate',
  Enum['yes','no']                              $hide_everyone                    = 'no',
  Enum['yes','no']                              $hide_system                      = 'yes',
  Enum['yes','no']                              $search_enabled                   = 'yes',
  String                                        $search_socket                    = 'file:///var/run/kopano/search.sock',
  Integer                                       $search_timeout                   = 10,
  Enum['yes','no']                              $enable_enhanced_ics              = 'yes',
  Enum['yes','no']                              $enable_sql_procedures            = 'no',
  Enum['yes','no']                              $sync_gab_realtime                = 'yes',
  Array[Enum['imap','pop3','mobile','outlook']] $disabled_features                = [ 'imap', 'pop3'],
  Integer                                       $max_deferred_records             = 0,
  Integer                                       $max_deferred_records_folder      = 20,
  Enum['yes','no']                              $restrict_admin_permissions       = 'no',
  Integer                                       $embedded_attachment_limit        = 20,
  String                                        $proxy_header                     = '',
  Enum['yes', 'no']                             $shared_reminders                 = 'yes',
) {

  package { $package_name:
    ensure => $package_version,
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

  file { '/etc/kopano/server.cfg':
    ensure  => file,
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    content => template('kopano/server.cfg.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
