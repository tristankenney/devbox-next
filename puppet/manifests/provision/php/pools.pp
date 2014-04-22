# Class: provision::php::pools
#
#
class provision::php::pools
{

  phpfpm::pool { 'user_bob':
    listen => $core::params::fpm_listen,
    user   => 'vagrant',
    group  => 'vagrant',
  }
}
