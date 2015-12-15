# == Class elastic_filebeat::config
#
# This class is called from elastic_filebeat for service config.
#
class elastic_filebeat::config {

include stdlib

  $elasticsearch_output_enabled     = $elastic_filebeat::elasticsearch_output_enabled
  $elasticsearch_output_hosts       = $elastic_filebeat::elasticsearch_output_hosts
  $elasticsearch_output_loadbalance = $elastic_filebeat::elasticsearch_output_loadbalance
  $elasticsearch_output_index       = $elastic_filebeat::elasticsearch_output_index
  $package_file                     = $elastic_filebeat::package_file
  $package_provider                 = $elastic_filebeat::package_provider
  $logstash_output_enabled          = $elastic_filebeat::logstash_output_enabled
  $logstash_output_hosts            = $elastic_filebeat::logstash_output_hosts
  $logstash_output_loadbalance      = $elastic_filebeat::logstash_output_loadbalance
  $logstash_output_index            = $elastic_filebeat::logstash_output_index
  $self_log_to_syslog               = $elastic_filebeat::self_log_to_syslog
  $self_log_to_files                = $elastic_filebeat::self_log_to_files
  $self_log_selectors               = $elastic_filebeat::self_log_selectors
  $self_log_level                   = $elastic_filebeat::self_log_level
  $self_log_path                    = $elastic_filebeat::self_log_path
  $self_log_name                    = $elastic_filebeat::self_log_name
  $self_log_rotateeverybytes        = $elastic_filebeat::self_log_rotateeverybytes
  $self_log_keepfiles               = $elastic_filebeat::self_log_keepfiles
  $paths                            = $elastic_filebeat::paths
  $input_type                       = 'log'



concat { $::elastic_filebeat::params::conf_file:
  ensure => present,
}

concat::fragment { 'filebeat_base':
  target  => $::elastic_filebeat::params::conf_file,
  content => template('elastic_filebeat/filebeat_base.erb'),
  order   => '01'
}

if is_array($::elastic_filebeat::output){

    if 'elasticsearch' in $::elastic_filebeat::output{

	concat::fragment { 'filebeat_output_elasticsearch':
	  target  => $::elastic_filebeat::params::conf_file,
  	  content => template('elastic_filebeat/filebeat_output_elasticsearch.erb'),
  	  order   => '02'
	}

    }

    if 'logstash' in $::elastic_filebeat::output{

         concat::fragment { 'filebeat_output_logstash':
          target  => $::elastic_filebeat::params::conf_file,
          content => template('elastic_filebeat/filebeat_output_logstash.erb'),
          order   => '03'
        }
    }   
}else{
notify {"Not a valid value type of paramtere output, value for parameter output must be in array format":}
}


concat::fragment { 'filebeat_shipper':
  target  => $::elastic_filebeat::params::conf_file,
  content => template('elastic_filebeat/filebeat_shipper.erb'),
  order   => '04'
}

concat::fragment { 'filebeat_logger':
  target  => $::elastic_filebeat::params::conf_file,
  content => template('elastic_filebeat/filebeat_logger.erb'),
  order   => '05'
}

concat::fragment { 'filebeat_prospector':
  target  => $::elastic_filebeat::params::conf_file,
  content => template('elastic_filebeat/filebeat_prospector.erb'),
  order   => '06'
}

}
