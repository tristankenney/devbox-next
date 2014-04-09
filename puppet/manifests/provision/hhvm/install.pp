# Class: provision::hhvm::install
#
#
class provision::hhvm::install
{
  apt::ppa { "ppa:mapnik/boost":
    before      => Package["hhvm"]
  }

  apt::source { "hhvm":
    location    => "http://dl.hhvm.com/ubuntu",
    release     => "precise",
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
