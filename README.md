# devbox-next

## What's inside

* [Ubuntu 12.04](http://releases.ubuntu.com/precise/)
* [Nginx](http://nginx.org/)
* [Mysql](http://www.mysql.com/)
* [PHP-FPM](http://php-fpm.org/)
* [Reis](http://redis.io/)
* [Nodejs](http://nodejs.org/)
* [HHVM FastCGI](http://www.hhvm.com/)

### Debug tools

* [Xdebug]() and [Webgrind](https://github.com/jokkedk/webgrind)
    - Requires the following entry in `/etc/hosts`: `192.168.33.10 webgrind`
* [XHProf](https://github.com/facebook/xhprof) and [XHProf.io](http://xhprof.io/)
    - Requires the following entry in `/etc/hosts`: `192.168.33.10 xhprof`


### PHP modules

devbox-next comes with the following PHP modules installed and enabled out-of-the-box:

* php-apc
* php5-gd
* php5-curl
* php5-memcache
* php5-mysql
* php5-mcrypt
* php5-xdebug
* yaml-beta

### PEAR Modules

* phing
* Symfony/Classloader
* Zend 1.7.8
* Doctrine 1.2.2
* PHPUnit
* Twig

## Getting started

1. Grab and install the appropriate version of [Vagrant] (http://www.vagrantup.com/downloads.html) for your distro.

2. Make sure you have both `/workspace` and `/srv/sites-enabled` available.

    `/workspace` needs to point to your Eclipse workspace directory.
    `sudo ln -s /home/{myusername}/workspace /workspace` should get you started.

    `/srv/sites-enabled/` is a directory containing symlinks that point to any web roots you'd like to serve.
    For example, if you would like to serve `http://mysite.myname` that resides in `/workspace/mysite/path/to/webroot` you would use the command `sudo ln -s /workspace/mysite/path/to/webroot/ /srv/sites-enabled/mysite.myname`. You would then be able to view the page in your browser at http://mysite.myname:8080 (Web requests are served at 8080)


3. Clone this repo into your workspace, cd into the directory and issue `vagrant up`. You might want to grab a coffee as provisioning the box can take a little while.


## Cheatsheet

### Root password
`vagrant` of course!

### SSH
You can access the machine in one of two ways, either by issuing the command `vagrant ssh` from within the cloned repository folder (this method doesn't require authentication information), or by SSHing using `vagrant@localhost -p 2222` using the password `vagrant`. The first method is preferred as it will accomodate for any port conflicts etc.

### Mysql
Mysql details are `root:root`, and you can access Mysql Server by connecting directly on port 3307 or by creating a tunnel on port 2222 and then connecting via localhost the previous details.

### Xdebug
Xdebug requires a slightly different setup.
[The when creating the server, it will need to be on the applicable port eg http://mysite.myname:8080,with path mapping via the /workspace symlink created earlier] (https://www.dropbox.com/s/sqnke14yrw6030g/Screenshot%202014-04-22%2015.22.54.png)

[Once that is done, you will need to map any items you wish to debug via the path mapping tab in server settings] (https://www.dropbox.com/s/y67lhzogssmfmbu/Screenshot%202014-04-22%2015.23.27.png)

### Webserver
All sites symlinked above will be availble at http://{url}:8080 for php-fpm and http://{url}:8081 for HHVM

---

Licensed under the terms of the [MIT License](LICENSE.md)