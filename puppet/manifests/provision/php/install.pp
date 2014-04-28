# Class: provision::php::install
#
#
class provision::php::install
{

  class { "php":
    service     => 'nginx',
    config_file => '/etc/php5/fpm/php.ini'
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

}
