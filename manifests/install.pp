# == Class elastic_filebeat::install
#
# This class is called from elastic_filebeat for install.
#
class elastic_filebeat::install {
  package { $::elastic_filebeat::params::package_name:
    ensure   => present,
    source   => $::elastic_filebeat::real_package_file,
    provider => $::elastic_filebeat::real_package_provider,
  }
  
  file { $::elastic_filebeat::params::conf_dir:
    ensure  => 'directory',
    require => Package[$::elastic_filebeat::params::package_name],
  }

  file { $::elastic_filebeat::params::confd_dir:
    ensure  => 'directory',
    purge   => true,
    recurse => true,
    require => File[$::elastic_filebeat::params::conf_dir],
  }
  
}
