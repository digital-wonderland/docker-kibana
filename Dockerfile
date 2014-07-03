# Kibana

FROM digitalwonderland/base

ADD ./src /

# Install packages
RUN rpm --import http://nginx.org/keys/nginx_signing.key \
    && yum install -y nginx tar \
    && rm /etc/nginx/conf.d/{default.conf,example_ssl.conf} \
    && yum clean all

# Install Kibana
RUN cd /tmp \
    && curl -O https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz \
    && tar xzf kibana-*.tar.gz \
    && rm kibana-*.tar.gz \
    && mkdir -p /var/www/vhosts \
    && mv kibana-* /var/www/vhosts/kibana


EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
