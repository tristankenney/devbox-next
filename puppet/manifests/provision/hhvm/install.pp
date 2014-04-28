# Class: provision::hhvm::install
#
#
class provision::hhvm::install
{
  apt::source { "hhvm":
    location    => "http://dl.hhvm.com/ubuntu",
    release     => "trusty",
    repos       => "main",
    include_src => false,
    key         => "hhvm",
    key_source  => "http://dl.hhvm.com/conf/hhvm.gpg.key",
    before      => Package["hhvm"]
  }

  package { "hhvm":
    ensure      => latest
  }
}
