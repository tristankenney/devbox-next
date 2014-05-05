include provision

import "./core/*", "./provision/**/*"
# Class: provision
#
#
class provision
{
  include core::params

  include apt

  include provision::ruby::install

  # PHP and PHP-FPM
  include provision::php::install,
          provision::php::modules,
          provision::php::pearpackages,
          provision::php::pools

  # mailcatcher
  include provision::mailcatcher::install

  # Nginx
  include provision::nginx::install,
          provision::nginx::vhosts

  # Mysql
  include provision::mysql::install


  # Nodejs
  include provision::nodejs::install,
          provision::nodejs::packages


  # redis
  include provision::redis::install



  # HHVM and HHVM FastCGI
  include provision::hhvm::install,
          provision::hhvm::service

  # XHProf and XHProf.io
  # include provision::xhprof::install,
  #         provision::xhprof::database,
  #         provision::xhprof::vhost

  # Webgrind
  include provision::webgrind::install,
          provision::webgrind::vhost


  package { 's3cmd':
    ensure  => installed
  }

  package { "curl":
    ensure  => installed
  }

  package { "vim":
    ensure  => installed
  }

  package { "htop":
    ensure  => installed
  }

  package { "memcached":
    ensure  => installed
  }

  package { "mercurial":
    ensure  => installed
  }



}
