# Class: provision::php::modules
#
#
class provision::php::modules
{
  $php_ini_dir     = "${core::params::templates_dir}/php/"
  $notify_services = [
    Service["nginx"],
    Service["hhvm-fastcgi"],
    Class["php::fpm::service"]
  ]


  package { "php5-dev":
     ensure => present
  }

  php::module { [ "cgi", "curl" ]:
    notify => $notify_services
  }

  php::module { [ "gd", "mysql", "sqlite", "mcrypt", "memcache", "xdebug" ]:
    notify  => $notify_services,
    content => $php_ini_dir,
  }

  php::module { "apc":
    package_prefix => "php-",
    notify         => $notify_services,
    content        => $php_ini_dir
  }

  package { "libyaml-dev": }

  # php::module { "beta":
  #   package_prefix => "yaml-"
  # }

  # package { "symfony2/ClassLoader":
  #    repository => "pear.symfony.com"
  # }

  # pear::package { "twig/Twig":
  #    repository => "pear.twig-project.org"
  # }

  # pear::package { "doctrine/Doctrine-1.2.2":
  #    repository => "pear.doctrine-project.org"
  # }

  # pear::package { "zend/Zend-1.7.8":
  #    repository => "zend.googlecode.com/svn"
  # }

}
