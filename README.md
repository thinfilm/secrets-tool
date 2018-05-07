# Thinfilm Secrets Sharing Tool

Forked From: [![Build Status](https://travis-ci.org/jhaals/yopass.svg)](https://travis-ci.org/jhaals/yopass)

A tool for sharing secrets in a quick and secure manner.

### Installation / Configuration
It's highly recommended to run TLS encryption using nginx/apache or the Golang built-in TLS server.

#### Docker

Start memcache container:

    docker run --name memcached_yopass -d memcached

Start tool container with TLS encryption:

    docker run -p 443:1337 -v /local/certs/:/certs -e TLS_CERT=/certs/tls.crt \
        -e TLS_KEY=/certs/tls.key -e 'MEMCACHED=memcache:11211' --link memcached_yopass:memcache -d thinfilm/secrets-tool
