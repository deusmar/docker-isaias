FROM docker.agricultura.gov.br/httpd-mapa:2.4

LABEL poject="MAPA - CentOS 7 - Apache HTTPD + PHP 5.6"
LABEL maintainer "cgti.docker@agricultura.gov.br"


ENV LIB_DEPS \
	libcurl \
	openssl \
	mcrypt \
	libmcrypt \
	httpd \
	openssl \
	mod_ssl \
	httpd-tools \
	libpq-dev

ENV PHP_EXT \
	php-soap \
	php-pecl-crypto \
	php-mbstring \
	php-pecl-zip \
	php-gd \
	php-cli \
	php \
	php-mcrypt \
	php-ldap \
	pdo \
	pdo_pgsql

RUN curl -s http://192.168.2.135/scripts/repos2/RemiRepoEL7_MAPA.repo -o /etc/yum.repos.d/RemiRepoEL7_MAPA.repo
RUN yum-config-manager --enable REMI7_PHP53-X86_64
RUN yum-config-manager --enable Remi7_safe-x86_64
RUN yum install -y --nogpg ${LIB_DEPS}
RUN yum install -y --nogpg ${PHP_EXT}

RUN	sed -i "s/^memory_limit.*/memory_limit = 2048M/" /etc/php.ini
RUN sed -i "s/^\;date.timezone.*/date.timezone = America\/Sao_Paulo/"  /etc/php.ini

RUN echo '<?php phpinfo(); ?>' > /var/www/html/info.php

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80
