FROM phusion/baseimage:latest
MAINTAINER Br4zzor <br4zzor@protonmail.com>

RUN apt-get update
RUN apt-get install -y wget curl

RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall


CMD msfconsole
