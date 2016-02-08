#!/bin/bash
#===============================================================================================================
#
#          FILE:  php_xdebug.sh
#
#         USAGE:  ./php_xdebug.sh
#
#   DESCRIPTION: Simple script switch xdebug on or off.
#                It is a enhancement (for OSx with Nginx & PHP-FPM) of this originally 
#                work (http://blog.somsip.com/2012/03/turn-php-xdebug-profiling-on-and-off-by-script/)
#                This script is configured to work on Homebrew Mac OSx with Nginx And PHP-FPM
#
#       OPTIONS:  on/off
#  REQUIREMENTS:  ---
#         USAGE:  php_xdebug on/off
#         NOTES:  ---
#        AUTHOR:  Cristiano Oliveira
#       COMPANY:  Scytale
#       VERSION:  1.0
#       CREATED:  ---
#      REVISION:  ---
#===============================================================================================================

echo 'Starting'

#Restart php-fpm and nginx
function restartServices {
    echo "stoping php-fpm and nginx"
    sudo killall php-fpm
    sudo nginx -s stop

    echo "starting php-fpm and nginx"
    sudo php-fpm &
    sudo nginx
}

case $1 in
  on)
    sudo sed -i '' 's/;zend_extension="\/usr\/local\/opt\/php56-xdebug\/xdebug\.so"/zend_extension="\/usr\/local\/opt\/php56-xdebug\/xdebug\.so"/g' /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini
    restartServices
  ;;
  off)
    sudo sed -i '' 's/zend_extension=\"\/usr\/local\/opt\/php56-xdebug\/xdebug\.so\"/;zend_extension=\"\/usr\/local\/opt\/php56-xdebug\/xdebug\.so\"/g' /usr/local/etc/php/5.6/conf.d/ext-xdebug.ini
    restartServices
  ;;
  *)
    echo "Usage: php_xdebug on|off"
  ;;
esac
