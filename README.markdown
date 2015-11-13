#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with elastic_filebeat](#setup)
    * [What elastic_filebeat affects](#what-elastic_filebeat-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with elastic_filebeat](#beginning-with-elastic_filebeat)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined Types](#defined-types)
    * [Templates](#templates)


##Overview

Install and configure Elasticsearch [filebeat](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-getting-started.html)

##Module Description

This puppet module installs filebeat official RPM from Elasticsearch with a fixed version (1.0.0-rc1 at the moment, waiting for filebeat release to implement other approach)

Actually only works with logstash output and without security, but it's easily expandable 

##Setup

###What elastic_filebeat affects

* Manage filebeat package, service and configuration
* Monopolizes /etc/filebeat/filebeat.yml file and /etc/filebeat/conf.d directory

###Beginning with elastic_filebeat

puppet module install pmovil-elastic_filebeat

##Usage

```puppet
    class {'elastic_filebeat':
        logstash_output_enabled: true
    }
    
    elastic_filebeat::prospector{'system_logs':
        paths: ['/var/log/*'],
    }
```

##Reference

###Classes
####`elastic_filebeat`
#####`package_file`
#####`package_provider`
#####`logstash_output_enabled`
#####`logstash_output_hosts`
#####`logstash_output_loadbalance`
#####`logstash_output_index`
#####`self_log_to_syslog`
#####`self_log_to_files`
#####`self_log_selectors`
#####`self_log_level`
#####`self_log_path`
#####`self_log_name`
#####`self_log_rotateeverybytes`
#####`self_log_keepfiles`

###Defined Types
####`elastic_filebeat::prospector`
#####`paths`
#####`input_type`
#####`encoding`
#####`fields`
#####`fields_under_root`
#####`ignore_older`
#####`document_type`
#####`scan_frequency`
#####`harvester_buffer_size`
#####`tail_files`
#####`backoff`
#####`max_backoff`
#####`backoff_factor`
#####`partial_line_waiting`
#####`force_close_windows_files`
