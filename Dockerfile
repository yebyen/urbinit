FROM yebyen/trusty:baseimage
RUN apt-get update
RUN apt-get -y install apt-utils dialog libterm-readline-perl-perl && apt-get clean
RUN apt-get -y install libgmp3-dev libsigsegv-dev && apt-get clean
RUN apt-get -y install openssl libssl-dev && apt-get clean
RUN apt-get -y install libncurses5-dev git && apt-get clean
RUN apt-get -y install make exuberant-ctags && apt-get clean
RUN apt-get -y install wget screen tmux unzip && apt-get clean
RUN wget http://github.com/urbit/urbit/archive/master.zip && unzip master.zip && rm /master.zip && mv urbit-master /urbit
RUN apt-get -y install gcc && apt-get clean
RUN cd /urbit && make
ADD ./_urbinit /.urbinit
RUN echo 'source $HOME/.profile' >/.bashrc
RUN echo 'export URBIT_HOME=/urbit/urb' >/.profile
CMD ["screen", "/.urbinit"]
