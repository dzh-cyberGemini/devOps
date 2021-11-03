FROM amazonlinux:2

RUN yum update -y && \
    amazon-linux-extras install nginx1 epel -y && \
    yum update -y && \
    yum install -y fcgi && \
    yum clean all

RUN groupadd -g 1000 app \
 && useradd -g 1000 -u 1000 -d /var/www -s /bin/bash app
RUN touch /var/run/nginx.pid && \
    mkdir /sock && \
    chown -R app:app /etc/nginx /var/run/nginx.pid /sock /var/lib/nginx && \
    pwd && \
    mkdir -p /var/www/magento && \
    chown -R app:app /var/www/magento

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
