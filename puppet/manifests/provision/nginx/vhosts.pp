# Class: provision::nginx::vhosts
#
#
class provision::nginx::vhosts
{
  $sites_dir = $core::params::sites_dir
  $nginx_dir = "${core::params::templates_dir}/nginx"

  nginx::vhost { "default":
    root     => "${sites_dir}",
    index    => "index.php",
    template => "${nginx_dir}/default.conf.erb"
  }

  nginx::vhost { "hhvm":
    root     => "${sites_dir}",
    index    => "index.php",
    template => "${nginx_dir}/hhvm.conf.erb"
  }
}
