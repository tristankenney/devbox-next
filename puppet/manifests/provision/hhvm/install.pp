# Class: provision::hhvm::install
#
#
class provision::hhvm::install
{

    exec { "hhvm source":
        command => "wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add - && echo deb http://dl.hhvm.com/ubuntu trusty main | tee /etc/apt/sources.list.d/hhvm.list && apt-get update",
        before  => Package['hhvm']
    }

    package { "hhvm":
        ensure      => latest
    }
}
