 # Class: provision::php::pear
#
#
class provision::php::pearpackages
{

  # php::pear::module { 'PHPUnit':
  #   repository  => 'pear.phpunit.de',
  #   use_package => 'no'
  # }

  php::pear::module { "Twig":
     repository    => "pear.twig-project.org",
     use_package => 'no'
  }

  php::pear::module { "ClassLoader":
     repository    => "pear.symfony.com",
     use_package => 'no'
  }

  php::pear::module { "Doctrine-1.2.2":
     repository    => "pear.doctrine-project.org",
     use_package => 'no'
  }

  php::pear::module { "Zend-1.7.8":
     repository    => "zend.googlecode.com/svn",
     use_package => 'no'
  }

  php::pear::module { "phing":
     repository    => "pear.phing.info",
     use_package => 'no'
  }

}