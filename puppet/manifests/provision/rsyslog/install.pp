# Class: provision::rsyslog::install
#
#
class provision::rsyslog::install
{
  class{'rsyslog::client':
    server         => '192.168.1.76'
  }
}
