# Class: provision::rsyslog::install
#
#
class provision::rsyslog::install
{
  class { 'rsyslog::server': }
}
