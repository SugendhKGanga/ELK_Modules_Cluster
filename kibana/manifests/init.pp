class kibana(

#$haproxy_group = $haproxy::params::haproxy_group,
#$haproxy_user = $haproxy::params::haproxy_user,
$kibana_archive_deb = $kibana::params::kibana_archive_deb,

)

inherits kibana::params
{

file { "/opt/${kibana_archive_deb}":
                ensure =>present,
                owner => root,
                group => root,
                source => "puppet:///modules/kibana/${kibana_archive_deb}",
                mode => 0755,

        }->

        package { "extract_kibana_archive_deb":
                provider => dpkg,
                ensure => installed,
                source => "/opt/${kibana_archive_deb}"
#               notify => Service['kibana'],

	}->        

#	exec {"run_config_setting":,
#                command => "/bin/sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/haproxy",
#        }->
	
	
       file { 'kibana Config File':
                path => "/opt/kibana/config/kibana.yml",
               ensure  => file,
                mode => 0777,
                content => template('kibana/kibana.yml.erb'),
	     }->

#-------
                file {"edit_es master ip _script_kibana":
                        path => "/opt/sed_master_ip_1.sh",
                        ensure => "present",
                        owner =>"${redis_user}",
                        group =>"${redis_group}",
                        mode => "0777",
                        source => "puppet:///modules/kibana/sed_master_ip_1.sh",
                  }->
                file {"es master ip input":
                        path => "/opt/redis_master_1.txt",
                        ensure => "present",
                        owner =>"${redis_user}",
                        group =>"${redis_group}",
                        mode => "0777",
                        source => "puppet:///modules/kibana/redis_master_1.txt",

                }->
#----
 exec {"run_kibana_config_setting":
                       user => "${redis_user}",
                        command => "/bin/bash /opt/sed_master_ip_1.sh",
#                        require => File["elasticsear"]
        }->
	

        service {'kibana':
                ensure => running,
                enable => true
        }

}
