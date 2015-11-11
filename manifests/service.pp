# == Class elastic_filebeat::service
#
# This class is meant to be called from elastic_filebeat.
# It ensure the service is running.
#
class elastic_filebeat::service {

  service { $::elastic_filebeat::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    
  }
}
