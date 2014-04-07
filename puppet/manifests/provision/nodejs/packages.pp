# Class: provision::nodejs::packages
#
#
class provision::nodejs::packages
{
    exec { 'npm install -g grunt-cli bower':,
        command => '/usr/bin/npm install -g grunt-cli bower',
        require => Package['nodejs'],
    }
}
