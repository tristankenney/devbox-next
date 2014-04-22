# Class: provision::nginx::install
#
#
class provision::nginx::install
{

  package { "apache2":
    ensure        => "absent"
  }

  class { "nginx":
    ensure        => present,
    default_vhost => "default"
  }
}
