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

  exec { 'install phpunit':
    command    => "wget https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit",
    require    => Exec['global composer'],
    unless     => "[ -f /usr/local/bin/phpunit ]"
  }

  exec { 'install codecept':
    command    => "wget http://codeception.com/codecept.phar && chmod +x codecept.phar && mv codecept.phar /usr/local/bin/codecept",
    require    => Exec['global composer'],
    unless     => "[ -f /usr/local/bin/codecept ]"
  }


}
