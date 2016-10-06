FROM officialkali/kali
MAINTAINER Br4zzor <br4zzor@protonmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y dist-upgrade && apt-get clean
RUN apt-get -y install curl postgresql metasploit-framework

RUN ["service","postgresql","start"]
RUN msfdb init

#Install Nightly builds
RUN apt-get -y remove metasploit-framework
RUN /usr/bin/curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
RUN chmod 755 msfinstall
RUN /msfinstall

# This shell script starts the postgresl service, waits for it to start msfconsole
COPY init.sh init.sh
RUN chmod 755 init.sh

CMD ["/bin/bash", "-c", "./init.sh"]
