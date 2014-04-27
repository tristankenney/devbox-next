# Class: provision::php::install
#
#
class provision::php::install
{

  apt::ppa { 'ppa:ondrej/php5': }

  class { "php":
    service     => 'nginx',
    config_file => '/etc/php5/fpm/php.ini',
    require     => Apt::Ppa['ppa:ondrej/php5']
  }

  class { 'phpfpm': }

  exec { 'install composer':
    command    => 'curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin',
    require    => Class['php'],
    unless     => "[ -f /usr/local/bin/composer ]"
  }

  exec { 'global composer':
    command    => "sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer",
    require    => Exec['install composer'],
    unless     => "[ -f /usr/local/bin/composer ]"
  }


  exec { 'move fpm config':
    command    => "mv /etc/php5/fpm/conf.d /etc/php5/fpm/conf.d.orig",
    unless     => "[ -d /etc/php5/fpm/conf.d.orig ]"
  }

  file { '/etc/php5/fpm/conf.d':
    ensure     => 'link',
    target     => '/etc/php5/conf.d',
    require    => Exec['move fpm config']
  }

}
