# devbox-next

## What's inside

* [Ubuntu 14.04](http://releases.ubuntu.com/trusty/)
* [Nginx](http://nginx.org/)
* [Mysql](http://www.mysql.com/)
* [PHP-FPM](http://php-fpm.org/)
* [Redis](http://redis.io/)
* [Nodejs](http://nodejs.org/)
* [HHVM FastCGI](http://www.hhvm.com/)
* [mailcatcher](http://mailcatcher.me/)
* Vim
* Mercurial
* cURL
* htop
* memcached


### Debug tools

* [Xdebug]() and [Webgrind](https://github.com/jokkedk/webgrind)
    - Requires the following entry in `/etc/hosts`: `192.168.33.10 webgrind`
* [XHProf](https://github.com/facebook/xhprof) and [XHProf.io](http://xhprof.io/)
    - Requires the following entry in `/etc/hosts`: `192.168.33.10 xhprof`


### PHP...

devbox-next comes with latest Trusty Tahr-supported PHP 5.5 version, plus the following PHP modules:

* php5-apcu
* php5-gd
* php5-json
* php5-curl
* php5-memcache
* php5-mysql
* php5-mcrypt
* php5-xdebug
* yaml

### ...and friends
* phing
* Symfony/Classloader
* Zend 1.7.8
* Doctrine 1.2.2
* PHPUnit
* Twig
* composer 


## Getting started

1. Grab and install the appropriate version of [Vagrant] (http://www.vagrantup.com/downloads.html) for your distro.



2. Create a symlink from your working files to `/workspace`. e.g.:

       
    	$ sudo ln -s /home/{myusername}/workspace /workspace 

3. Create a folder of symlinks at `/srv/sites-enabled/` that point to web roots that reside your workspace, relative to `/workspace`. For example, if you would like to serve `http://mysite.myname` that resides in `/workspace/mysite/path/to/webroot` you would use the command 
        
        $ sudo ln -s /workspace/mysite/path/to/webroot/ /srv/sites-enabled/mysite.myname
    
    You would then be able to view the page in your browser at http://mysite.myname:8080 (Web requests are served at 8080)

4. Clone this repo
	
		$ git clone git@github.com:tristankenney/devbox-next.git
		$ cd devbox-next
		
5. Add the Trusty box to Vagrant (this will take a while)
		
		$ vagrant box add 'ubuntu/trusty64'
		
6. Provision the machine (this will also take a while)

		$ vagrant up




## Cheat sheet
### Files
Files that are accessible within your local system at the symlink `/workspace` are available on the Vagrant machine at the same location, `/workspace`. You can and should perform all local development tasks directly on the Vagrant machine, rather than on your native machine (builds, testing etc) as this ensures that correct permissions are used, and then local resources such as databases are created on the Vagrant machine rather than on your native machine.

### Root password
`vagrant` of course!

### SSH
You can access the machine in one of two ways, either by issuing the command `vagrant ssh` from within the cloned repository folder (this method doesn't require authentication information), or by SSHing using `vagrant@localhost -p 2222` using the password `vagrant`. The first method is preferred as it will accommodate for any port conflicts etc.

### Mysql
Mysql details are `root:root`, and you can access Mysql Server by connecting directly on port 33307 or by creating a tunnel on port 2222 and then connecting via localhost the previous details.

### XDebug
XDebug requires a slightly more involved setup than you may be used to.

#### Web app debugging

Setup sites to be debugged as per normal (on port 8080). 

Anything you would like to be able to have breakpoints against will need to be [mapped within Eclipse](https://www.dropbox.com/s/y67lhzogssmfmbu/Screenshot%202014-04-22%2015.23.27.png)

Mapping should be done using both /workspace mappings avoid confusion


#### CLI debugging

To debug cli scripts, you will need [JIT debugging enabled within Eclipse](https://www.dropbox.com/s/mwfz509trs07326/Screenshot%202014-04-29%2009.01.32.png)

	XDEBUG_CONFIG="idekey=ECLIPSE_DBGP" \
	XDEBUG_SESSION_START=ECLIPSE_DBGP \
	php \
	-f script.php



### Web server
All sites symlinked above will be available at http://{url}:8080 for php-fpm and http://{url}:8081 for HHVM

## Development

Now that you are all setup it's time to develop.
Because your workspace via the `/workspace` symlink along with you sites via `/srv/sites-enabled` you can develop as normal on your native machine. All changes are reflected on the Virtual Machine immediately.

When you need direct access to the virtual machine, you can SSH into the Vagrant machine using one of the above commands, and access your files via `/workspace`. As this folder is mounted via NFS, you may occasionally run into file permission issues. If this is the case, you can perform the same operation in the folder `/workspace-direct` which is mounted directly.
One notable instance of this is when using the `npm install`.

NB: direct access is *much* slower than NFS mounted folders, and as such will have a noticeable impact on performance. As such it recommended to perform all operations using the `/workspace` folder where possible.

If you care to read more about this fascinating subject, head over to 

## TODO

* Elasticsearch
* fix warnings / update import/* syntax

---

Licensed under the terms of the [MIT License](LICENSE.md)
