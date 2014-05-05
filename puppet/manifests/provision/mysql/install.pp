# Class: provision::mysql::install
#
#
class provision::mysql::install
{
    $grants = {
        'root@/*.*' => {
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => ['ALL'],
            table      => '*.*',
            user       => 'root@%',
        }
    }

    class { "mysql::server":
        root_password    => $core::params::dbpassword,
        grants           => $grants,
        override_options => {
            'mysqld' => {
                'bind-address'       => '0.0.0.0',
                'max_allowed_packet' => '512M'
            }
        }
    }
}
