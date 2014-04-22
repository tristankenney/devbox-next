# Class: provision::xhprof::install
#
#
class provision::xhprof::install
{
  package { "php5-common":
    ensure  => installed
  }

  package { "graphviz":
    ensure => installed
  }

  php::pecl::module { "xhprof":
    use_package     => 'false',
    preferred_state => 'beta',
    require         => [Package['php5-common'], Package['graphviz']]
  }

  file { "xhprof_ini":
    ensure  => file,
    path    => "/etc/php5/conf.d/xhprof.ini",
    source  => "${core::params::templates_dir}/xhprof/xhprof.ini.erb",
    notify  => $provision::php::modules::notify_services
  }

  vcsrepo { "/usr/share/xhprof.io":
    ensure   => present,
    provider => git,
    source   => "git://github.com/gajus/xhprof.io.git"
  }

  file { "xhprof_io_config":
    ensure  => file,
    path    => "/usr/share/xhprof.io/xhprof/includes/config.inc.php",
    source  => "${core::params::templates_dir}/xhprof/config.inc.php.erb"
  }
}
