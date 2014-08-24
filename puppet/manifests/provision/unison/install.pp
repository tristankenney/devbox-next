class provision::unison::install
{
    package { "unison":
        ensure  => present
    }

    file { "workspace":
        path   =>  "/workspace",
        ensure => "directory",
        mode   => 0777
    }

    file { '/etc/init.d/unison-workspace':
       ensure  => 'file',
       mode => 0770,
       group => root,
       content => template("${core::params::templates_dir}/unison/unison-workspace.erb"),
       notify  => Service['unison-workspace'],
       require => Package['unison']
    }

    service { 'unison-workspace':
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
    }

}
