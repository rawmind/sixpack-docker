FROM ubuntu
MAINTAINER Andrei Kovrov <a@devs.team>

# setup repository
RUN apt-get update
RUN apt-get install -y wget tar git python-setuptools python-dev python-pip

# setup sixpack
RUN mkdir -p /home/sixpack
WORKDIR /home/sixpack
RUN git clone https://github.com/rawmind/sixpack

WORKDIR /home/sixpack/sixpack
RUN pip install -r requirements.txt

# setup supervisord
RUN pip install supervisor
RUN mkdir -p /etc/supervisord.d/
RUN mkdir -p /var/log/supervisor
ADD template/supervisord.conf /etc/supervisord.conf
ARG API=yes
ADD template/supervisord.d/sixpack.ini /tmp/sixpack.ini
RUN if [ $API = 'yes' ] ; then mv /tmp/sixpack.ini  /etc/supervisord.d/sixpack.ini; else rm /tmp/sixpack.ini; fi
ADD template/supervisord.d/sixpack-web.ini /tmp/sixpack-web.ini
ARG WEB=no
RUN if [ $WEB = 'yes' ] ; then mv /tmp/sixpack-web.ini  /etc/supervisord.d/sixpack-web.ini; else rm /tmp/sixpack-web.ini; fi

# start server
WORKDIR /home/sixpack
CMD supervisord -c /etc/supervisord.conf
