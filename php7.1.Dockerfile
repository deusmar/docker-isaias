FROM docker.agricultura.gov.br/httpd-mapa:2.4

LABEL poject="MAPA - CentOS 7 - Apache HTTPD + PHP 7.3"
LABEL maintainer "cgti.docker@agricultura.gov.br"

RUN curl -s http://192.168.2.135/scripts/repos2/RemiRepoEL7_MAPA.repo -o /etc/yum.repos.d/RemiRepoEL7_MAPA.repo && \
    yum-config-manager --enable REMI7_PHP73-X86_64 && \
    yum-config-manager --enable Remi7_safe-x86_64 && \
    yum install -y --nogpg libcurl openssl mcrypt libmcrypt httpd openssl mod_ssl httpd-tools php-soap php-pecl-crypto php-mbstring php-pecl-zip php-gd php-cli php php-ldap php-mcrypt && \
    sed -i "s/^memory_limit.*/memory_limit = 2048M/" /etc/php.ini && \
    sed -i "s/^\;date.timezone.*/date.timezone = America\/Sao_Paulo/"  /etc/php.ini && \
    echo '<?php phpinfo(); ?>' > /var/www/html/info.php

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80
