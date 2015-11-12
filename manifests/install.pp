# == Class elastic_filebeat::install
#
# This class is called from elastic_filebeat for install.
#
class elastic_filebeat::install {
  package { $::elastic_filebeat::params::package_name:
    ensure   => present,
    source   => $::elastic_filebeat::params::package_file,
    provider => $::elastic_filebeat::params::provider,
  }
}
