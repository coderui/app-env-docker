#!/bin/bash

case "$1" in
    start)
        echo '[-] Starting Apache'
        apachectl -k start
        
        echo '[-] Changing permissions for /var/www/html'
        chown apache -R /var/www/html
        chmod 777 -R /var/www/html

        echo '[-] Waiting for HTTPD to start'
        while true
        do
            curl -I 127.0.0.1:80 &>/dev/null && break
            sleep 1
        done
    ;;
    stop)
        apachectl -k stop
    ;;
    reload)
        apachectl -k reload
    ;;
    restart)
		$0 stop
		$0 start
	;;
    *)
		echo Unknown action: $1
	;;

esac
