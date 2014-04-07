# Class: provision::mysql::install
#
#
class provision::mysql::install
{
  class { "mysql::server":
    root_password   => $core::params::dbpassword,
  }
}
