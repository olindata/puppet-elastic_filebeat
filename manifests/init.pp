# Class: elastic_filebeat
# ===========================
#
# Full description of class elastic_filebeat here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class elastic_filebeat (
  $logstash_output_enabled = false,
  $logstash_output_hosts = ["localhost:5044"],
  $logstash_output_loadbalance = undef,
  $logstash_output_index = undef,
  
  
  $log_to_syslog = undef,
  $log_to_files = undef,
  $log_selectors = [],
  $log_level = undef,
  $log_path = undef,
  $log_name = undef,
  $log_rotateeverybytes = undef,
  $log_keepfiles = undef
  
) inherits ::elastic_filebeat::params {

  if($logstash_output_loadbalance != undef){
    validate_bool($logstash_output_loadbalance)
  }
 
  class { '::elastic_filebeat::install': } ->
  class { '::elastic_filebeat::config': } ~>
  class { '::elastic_filebeat::service': } ->
  Class['::elastic_filebeat']
    
}
