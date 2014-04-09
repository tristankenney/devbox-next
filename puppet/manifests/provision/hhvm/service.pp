# Class: provision::hhvm::service
#
#
class provision::hhvm::service
{
  service { "hhvm-fastcgi":
    ensure     => running,
    enable     => true,
    require    => Package["hhvm"],
    binary     => "/etc/init.d/hhvm-fastcgi",
    hasrestart => true,
    hasstatus  => true,
  }

  file { "hhvm_config":
    ensure  => file,
    path    => "/etc/hhvm/server.hdf",
    source  => "${core::params::templates_dir}/hhvm/server.hdf.erb",
    require => Package["hhvm"],
    before  => Service["hhvm-fastcgi"],
    notify  => Service["hhvm-fastcgi"]
  }

  file { "hhvm_init":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 0777,
    path    => "/etc/init.d/hhvm-fastcgi",
    source  => "${core::params::templates_dir}/hhvm/hhvm-fastcgi.erb",
    require => Package["hhvm"],
    before  => Service["hhvm-fastcgi"],
    notify  => Service["hhvm-fastcgi"]
  }
}