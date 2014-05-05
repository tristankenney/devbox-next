#!/bin/bash
# kill php-fpm and restart, due to weirdness https://bugs.launchpad.net/ubuntu/+source/php5/+bug/1272788
sudo service php5-fpm stop
sudo pkill -f php5-fpm
sudo pkill php5-fpm
sudo service php5-fpm restart
