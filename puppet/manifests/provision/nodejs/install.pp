# Class: provision::nodejs::install
#
#
class provision::nodejs::install
{

    apt::ppa { "ppa:chris-lea/node.js":
        before => Package['nodejs']
    }

    package { "python-software-properties":
        ensure => installed,
        before => Package['nodejs']
    }

    package { "python":
        ensure => installed,
        before => Package['nodejs']
    }

    package { "g++":
        ensure => installed,
        before => Package['nodejs']
    }

    package { "nodejs":
        ensure => latest
    }

}
