# Class: provision::elasticsearch::install
#
#
class provision::elasticsearch::install
{
    class {'java': }

    class {'elasticsearch':
        package_url => 'https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.deb',
        config => {
            'node'                   => {
                'name'               => 'elasticsearch001'
            },
            'index'                  => {
                'number_of_replicas' => '0',
                'number_of_shards'   => '5'
            },
            'network'                => {
                'host'               => $::ipaddress
            }
        },
        require => Class['java']
    }

    exec { 'install attachment-mapper':
        command    => '/usr/share/elasticsearch/bin/plugin '
    }

}
