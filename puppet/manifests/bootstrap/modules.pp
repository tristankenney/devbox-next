# Class: bootstrap::modules
#
#
class bootstrap::modules
{
  package { "ruby-dev":
    ensure   => installed
  } ->

  package { "puppet":
    ensure   => installed,
    provider => "gem"
  } ->

  package { "facter":
    ensure   => "2.0.1",
    provider => "gem"
  } ->

  package { "librarian-puppet":
    ensure   => installed,
    provider => "gem"
  } ->

  exec { "librarian-puppet install":
    cwd => $core::params::puppet_dir
  }
}
