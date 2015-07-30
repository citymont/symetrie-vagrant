# Puppet configurations

Exec { path =>  [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class base {

  ## Update apt-get ##
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
}

class http {

  define apache::loadmodule () {
    exec { "/usr/sbin/a2enmod $name" :
      unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
      notify => Service[apache2]
    }
  }

  apache::loadmodule{"rewrite":}

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }
}

class composer {
  
  exec { 'composer':
    command => 'curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer'
  }

  
}

class php{

  package { "php5":
    ensure => present,
  }

  package { "php5-cli":
    ensure => present,
  }

  package { "php5-xdebug":
    ensure => present,
  }

  package { "php5-imagick":
    ensure => present,
  }

  package { "php5-mcrypt":
    ensure => present,
  }

  package { "php-pear":
    ensure => present,
  }

  package { "php5-dev":
    ensure => present,
  }

  package { "php5-curl":
    ensure => present,
  }

  package { "php5-sqlite":
    ensure => present,
  }

  package { "libapache2-mod-php5":
    ensure => present,
  }

}


include base
include http
include php
include composer