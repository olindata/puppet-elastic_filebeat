# Definition: elastic_filebeat::prospector
#
# This type defines a filebeat prospector
#
define elastic_filebeat::prospector (
  $paths                     = [],
  $input_type                = 'log',
  $encoding                  = undef,
  $fields                    = {
  }
  ,
  $fields_under_root         = undef,
  $ignore_older              = undef,
  $document_type             = undef,
  $scan_frequency            = undef,
  $harvester_buffer_size     = undef,
  $tail_files                = undef,
  $backoff                   = undef,
  $max_backoff               = undef,
  $backoff_factor            = undef,
  $partial_line_waiting      = undef,
  $force_close_windows_files = undef) {
  if ($fields_under_root != undef) {
    validate_bool($fields_under_root)
  }

  if ($tail_files != undef) {
    validate_bool($tail_files)
  }

  if ($force_close_windows_files != undef) {
    validate_bool($force_close_windows_files)
  }

  if ($harvester_buffer_size != undef) {
    if !is_integer($harvester_buffer_size) {
      fail('harvester_buffer_size should be an integer')
    }
  }

  if ($backoff_factor != undef) {
    if !is_integer($backoff_factor) {
      fail('backoff_factor should be an integer')
    }
  }

  file { "${::elastic_filebeat::params::confd_dir}/${name}.yml":
    ensure  => 'file',
    content => template('elastic_filebeat/prospector.yml.erb'),
    require => [Package[$::elastic_filebeat::params::package_name], File[$elastic_filebeat::params::confd_dir]],
    notify  => Service[$::elastic_filebeat::params::service_name],
  }

}