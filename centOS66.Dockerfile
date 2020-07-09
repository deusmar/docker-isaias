FROM docker.agricultura.gov.br/centos-mapa:6.6

LABEL poject="MAPA - CentOS 6.6 - Apache HTTPD"
LABEL maintainer "cgti.docker@agricultura.gov.br"

WORKDIR $ROOT_DIR

ENV ROOT_DIR /var/www/html
ENV USER userAPP
ENV GROUP groupAPP

ENV APACHE_CONF /etc/httpd/conf/httpd.conf

ENV LIB_DEPS \
  libcurl \
  openssl \
  mcrypt \
  libmcrypt \
  httpd \
  openssl \
  mod_ssl \
  httpd-tools

RUN yum install -y --nogpg ${LIB_DEPS}; yum clean all
#configuração dos logs
RUN sed -i 's/logs\/access_log/\/proc\/self\/fd\/1/g' ${APACHE_CONF} \
  && sed -i 's/logs\/error_log/\/proc\/self\/fd\/2/g' ${APACHE_CONF} \
  && sed -i 's/#ServerName www.example.com/ServerName localhost/g' ${APACHE_CONF}

RUN echo "/sbin/service httpd start" >> /root/.bashrc

EXPOSE 80