# Class: provision::php::install
#
#
class provision::php::install
{
  # PHP 5.5 repo
  # apt::ppa { "ppa:ondrej/php5":
  #   before => Class['php'],
  # }

  class { "php": }
  class { "php::fpm": }

  exec { 'install composer':
    command => 'curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin',
    require => Class['php'],
    unless => "[ -f /usr/local/bin/composer ]"
  }

  exec { 'global composer':
    command => "sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer",
    require => Exec['install composer'],
    unless => "[ -f /usr/local/bin/composer ]"
  }

  exec { 'install laravel':
    command => "curl -s http://laravel.com/laravel.phar > /usr/local/bin/laravel",
    unless  => "[ -f /usr/local/bin/laravel ]"
  }
}
