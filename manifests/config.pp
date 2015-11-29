# == Class elastic_filebeat::config
#
# This class is called from elastic_filebeat for service config.
#
class elastic_filebeat::config {

include stdlib

concat { $::elastic_filebeat::params::conf_file:
  ensure => present,
}

concat::fragment { 'filebeat_base':
  target  => $::elastic_filebeat::params::conf_file,
  content => template('elastic_filebeat/filebeat_base.erb'),
  order   => '01'
}

if is_array($::elastic_filebeat::init::output){

    if 'elasticsearch' in $::elastic_filebeat::init::output{

	concat::fragment { 'filebeat_output_elasticsearch':
	  target  => $::elastic_filebeat::params::conf_file,
  	  content => template('elastic_filebeat/filebeat_output_elasticsearch.erb'),
  	  order   => '02'
	}

    }

    if 'logstash' in $::elastic_filebeat::init::output{

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

}
