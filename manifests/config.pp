# == Class elastic_filebeat::config
#
# This class is called from elastic_filebeat for service config.
#
class elastic_filebeat::config {
  file { $::elastic_filebeat::params::conf_file:
    ensure  => 'file',
    content => template('elastic_filebeat/filebeat.yml.erb'),
  }

}