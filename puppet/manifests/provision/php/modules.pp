# Class: provision::php::modules
#
#
class provision::php::modules
{
  $php_ini_dir     = "${core::params::templates_dir}/php/"
  $notify_services = [
    Service["nginx"],
    Service["hhvm-fastcgi"],
    Class['phpfpm::service']
  ]


  package { "php5-dev":
     ensure        => present
  }

  package { "libyaml-dev": }

  php::module { [ "cgi", "curl" ]:
    notify         => $notify_services,
    require        => Class['php']
  }

  php::module { [ "gd", "mysql", "mcrypt", "memcache", "xdebug", "json"]:
    notify         => $notify_services,
    require        => [Class['php'], Package['libyaml-dev']]
  }

  # make betterer
  exec { "pecl install yaml":
    require => [Class['php'], Package["libyaml-dev"]],
    notify  => $notify_services,
    unless  => '[ -f /usr/lib/php5/20121212/yaml.so ]'
  }

  file { "xdebug_ini":
    ensure  => file,
    path    => "/etc/php5/mods-available/xdebug.ini",
    content => template("${core::params::templates_dir}/php/xdebug.ini.erb"),
    notify  => $notify_services
  }

  file { "php_ini":
    ensure  => file,
    path    => "/etc/php5/mods-available/php.ini",
    content => template("${core::params::templates_dir}/php/php.ini.erb"),
    notify  => $notify_services
  }

  file { "yaml_ini":
    ensure  => file,
    path    => "/etc/php5/mods-available/yaml.ini",
    content => template("${core::params::templates_dir}/php/yaml.ini.erb"),
    notify  => $notify_services
  }

  exec { "php5enmod -s ALL yaml":
    require => File['yaml_ini'],
    notify  => $notify_services
  }

  exec { "php5enmod -s ALL mcrypt": }

  file { "/etc/php5/cli/conf.d/1-php.ini":
    ensure  => link,
    target  => "/etc/php5/mods-available/php.ini",
    notify  => $notify_services,
    require => File['php_ini']
  }

  file { "/etc/php5/fpm/conf.d/1-php.ini":
    ensure  => link,
    target  => "/etc/php5/mods-available/php.ini",
    notify  => $notify_services,
    require => File['php_ini']
  }

}
