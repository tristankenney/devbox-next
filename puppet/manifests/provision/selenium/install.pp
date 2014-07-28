class provision::selenium::install
{
    $install_url = 'http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar'
    $jar = 'selenium-server-standalone-2.42.2.jar'

    package { "xvfb":
        ensure  => present
    }


    file { "/opt/selenium":
        ensure  => directory
    }

    file { "/etc/init.d/selenium":
       ensure  => file,
       content => template("${core::params::templates_dir}/selenium/selenium.erb")
    }

    exec { 'install selenium':
       command    => "wget ${install_url} && chmod +x ${jar} && mv ${jar} /opt/selenium/selenium-standalone.jar",
       unless     => "[ -f /opt/selenium/selenium-standalone.jar ]",
       require    => [File["/opt/selenium"], File["/etc/init.d/selenium"]]
    }


}
