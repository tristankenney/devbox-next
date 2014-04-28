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

  php::module { "apc":
    module_prefix => "php-",
    require        => Class['php']
  }

  php::pecl::module { "yaml-beta":
    require        => Package["libyaml-dev"],
    use_package   => 'no'
  }

  file { "json_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/json.ini",
    content => template("${core::params::templates_dir}/php/json.ini.erb"),
    notify  => $notify_services
  }

  file { "php_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/php.ini",
    content => template("${core::params::templates_dir}/php/php.ini.erb"),
    notify  => $notify_services
  }

  file { "apc_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/apc.ini",
    content => template("${core::params::templates_dir}/php/apc.ini.erb"),
    notify  => $notify_services
  }

  file { "gd_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/gd.ini",
    content => template("${core::params::templates_dir}/php/gd.ini.erb"),
    notify  => $notify_services
  }

  file { "mcrypt_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/mcrypt.ini",
    content => template("${core::params::templates_dir}/php/mcrypt.ini.erb"),
    notify  => $notify_services
  }

  file { "memcache_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/memcache.ini",
    content => template("${core::params::templates_dir}/php/memcache.ini.erb"),
    notify  => $notify_services
  }

  file { "mysql_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/mysql.ini",
    content => template("${core::params::templates_dir}/php/mysql.ini.erb"),
    notify  => $notify_services
  }

  file { "xdebug_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/xdebug.ini",
    content => template("${core::params::templates_dir}/php/xdebug.ini.erb"),
    notify  => $notify_services
  }

  file { "yaml-beta_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/yaml-beta.ini",
    content => template("${core::params::templates_dir}/php/yaml-beta.ini.erb"),
    notify  => $notify_services
  }

}
