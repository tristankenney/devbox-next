# Class: provision::hhvm::install
#
#
class provision::hhvm::install
{
  package { "hhvm":
    ensure      => latest
  }
}
