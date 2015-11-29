# Class: elastic_filebeat
#===========================
#
# Full description of class elastic_filebeat here.
#
# Parameters
#----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class elastic_filebeat (
  $elasticsearch_output_enabled     = false,
  $elasticsearch_output_hosts       = ['localhost:5044'],
  $elasticsearch_output_loadbalance = undef,
  $elasticsearch_output_index       = undef,
  $package_file               	    = '',
  $package_provider                 = '',
  $logstash_output_enabled          = false,
  $logstash_output_hosts            = ['localhost:5044'],
  $logstash_output_loadbalance      = undef,
  $logstash_output_index            = undef,
  $output                           = [], 
  $self_log_to_syslog               = undef,
  $self_log_to_files                = undef,
  $self_log_selectors               = [],
  $self_log_level                   = undef,
  $self_log_path                    = undef,
  $self_log_name                    = undef,
  $self_log_rotateeverybytes        = undef,
  $self_log_keepfiles               = undef) inherits ::elastic_filebeat::params {
    
  if ($logstash_output_loadbalance != undef) {
    validate_bool($logstash_output_loadbalance)
  }

  validate_array($logstash_output_hosts)

  if($package_file != ''){
    $real_package_file = $package_file
  } else {
    if($::operatingsystem == 'Fedora' and versioncmp($::operatingsystemrelease, '14') <= 0){
        fail('Actual filebeat RPM is not compatible with old RPM systems needs rpmlib(TildeInVersions). You need to regenerate RPM without tildes on version and supply package_file')
    }
    $real_package_file = $::elastic_filebeat::params::default_package_file
  }

  if($package_provider != ''){
    $real_package_provider = $package_provider
  } else {
    $real_package_provider = $::elastic_filebeat::params::default_package_provider
  }

  class { '::elastic_filebeat::install': } ->
  class { '::elastic_filebeat::config': } ~>
  class { '::elastic_filebeat::service': } ->
  Class['::elastic_filebeat']
  

}
