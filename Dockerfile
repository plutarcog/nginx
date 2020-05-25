FROM centos:7
MAINTAINER Plutarco Guerrero, plutarcog@gmail.com

RUN set -eux; \
	yum update -y; \
	yum install -y \
	wget \
        gzip \
        tar \
        binutils \
	yum-utils \
        freetype fontconfig; \
        rm -rf /var/cache/yum; \
#Download and Import Nginx public key
        wget https://nginx.org/keys/nginx_signing.key; \
        gpg --import nginx_signing.key

# Add Nginx repo.
COPY nginx.repo /etc/yum.repos.d

# Install Nginx
RUN set -eux; \
  yum update -y; \
  yum install -y nginx

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
