# == Class elastic_filebeat::config
#
# This class is called from elastic_filebeat for service config.
#
class elastic_filebeat::config () {
  $confd_dir = $::elastic_filebeat::params::confd_dir
  $logstash_output_enabled = $::elastic_filebeat::logstash_output_enabled
  $logstash_output_hosts = $::elastic_filebeat::logstash_output_hosts
  $logstash_output_index = $::elastic_filebeat::logstash_output_index
  $logstash_output_loadbalance = $::elastic_filebeat::logstash_output_loadbalance

  $log_to_syslog = $elastic_filebeat::log_to_syslog
  $log_to_files = $elastic_filebeat::log_to_files
  $log_selectors = $elastic_filebeat::log_selectors
  $log_path = $elastic_filebeat::log_path
  $log_name = $elastic_filebeat::log_name
  $log_rotateeverybytes = $elastic_filebeat::log_rotateeverybytes
  $log_level = $elastic_filebeat::log_level

  file { $::elastic_filebeat::params::conf_dir: ensure => 'directory' }

  file { $::elastic_filebeat::params::confd_dir:
    ensure  => 'directory',
    purge   => true,
    recurse => true,
  }

  file { $::elastic_filebeat::params::conf_file:
    ensure  => 'file',
    content => template('elastic_filebeat/filebeat.yml.erb'),
    require => File[$::elastic_filebeat::params::confd_dir],
    notify  => Service[$::elastic_filebeat::params::service_name],
  }

}
