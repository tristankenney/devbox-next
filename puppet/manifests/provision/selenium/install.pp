class provision::selenium::install
{
    $install_url = 'http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar'
    $jar = 'selenium-server-standalone-2.42.2.jar'


    package { "firefox":
        ensure  => present
    }

    /* Selenium */
    file { "/opt/selenium":
        ensure  => directory
    }

    file { "/etc/init.d/selenium":
       ensure  => file,
       mode => 0770,
       group => root,
       content => template("${core::params::templates_dir}/selenium/selenium.erb")
    }

    exec { 'install selenium':
       command    => "wget ${install_url} && chmod +x ${jar} && mv ${jar} /opt/selenium/selenium-standalone.jar",
       unless     => "[ -f /opt/selenium/selenium-standalone.jar ]",
       require    => [File["/opt/selenium"], File["/etc/init.d/selenium"]]
    }

    /* xvfb */
    package { "xvfb":
        ensure  => present
    }

    file { "/etc/init.d/xvfb":
       ensure  => file,
       mode => 0770,
       group => root,
       content => template("${core::params::templates_dir}/selenium/xvfb.erb"),
       require => Package['xvfb'],
       notify => Service['xvfb']
    }

    service { "xvfb":
        ensure => running
    }

    /* x11vnc */
    package { "x11vnc":
        ensure => present
    }

    file { '/etc/init.d/x11vnc':
        content => template("${core::params::templates_dir}/selenium/x11vnc.erb"),
        mode    => '0755',
        require => Package['x11vnc'],
        notify  => Service['x11vnc'],
    }

    service { 'x11vnc':
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
    }




}
