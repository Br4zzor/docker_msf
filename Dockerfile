FROM alpine:latest
MAINTAINER Br4zzor <br4zzor@protonmail.com>


ENV PATH=$PATH:/usr/share/metasploit-framework 
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1

RUN echo "http://nl.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories && \
    echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
	apk add \
	build-base \
	ruby \
	ruby-bigdecimal \
	ruby-bundler \
	ruby-io-console \
	ruby-dev \
	libffi-dev\
        openssl-dev \
	readline-dev \
	sqlite-dev \
	postgresql-dev \
        libpcap-dev \
	libxml2-dev \
	libxslt-dev \
	yaml-dev \
	zlib-dev \
	ncurses-dev \
        autoconf \
	bison \
	subversion \
	git \
	sqlite \
	nmap \
	libxslt \
	postgresql \
        ncurses 

RUN cd /usr/share && \
    git clone https://github.com/rapid7/metasploit-framework.git && \
    cd /usr/share/metasploit-framework && \
    bundle install

RUN apk del \
	build-base \
	ruby-dev \
	libffi-dev\
        openssl-dev \
	readline-dev \
	sqlite-dev \
	postgresql-dev \
        libpcap-dev \
	libxml2-dev \
	libxslt-dev \
	yaml-dev \
	zlib-dev \
	ncurses-dev \
	bison \
	autoconf \
	&& rm -rf /var/cache/apk/*

#Database initializer
#RUN /etc/init.d/postgresql setup 
#RUN /etc/init.d/postgresql start 
RUN msfdb init

#Nightly builds
#RUN apk del metasploit-framework
#RUN /usr/bin/curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
#RUN chmod 755 msfinstall
#RUN /msfinstall

#Starts the postgresl service then msfconsole
#COPY init.sh init.sh
#RUN chmod 755 init.sh

VOLUME [ "/usr/share/metasploit-framework" ]
ENTRYPOINT ["msfconsole"]
