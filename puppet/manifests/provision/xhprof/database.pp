# Class: provision::xhprof::database
#
#
class provision::xhprof::database
{
  $seed  = "/usr/share/xhprof.io/setup/database.sql"
  $mysql = "mysql --user='xhprof' --password='xhprof'"

  mysql::db { "xhprof":
    user => 'xhprof',
    password => 'xhprof',
    ensure  => present
  }

  exec { "xhprof_import":
    command     => "${mysql} xhprof < '${seed}'",
    timeout     => 0,
    refreshonly => true,
    require     => Vcsrepo["/usr/share/xhprof.io"],
    subscribe   => Mysql::Db["xhprof"]
  }
}
