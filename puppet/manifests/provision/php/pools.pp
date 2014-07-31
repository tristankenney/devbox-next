# Class: provision::php::pools
#
#
class provision::php::pools
{

  phpfpm::pool { 'www':
    listen => $core::params::fpm_listen,
    user   => 'vagrant',
    group  => 'vagrant',
    catch_workers_output => true,
    listen_owner => 'www-data',
    listen_group => 'www-data',
    listen_mode  => 0660,
  }
}
