FROM tianon/debian:wheezy
RUN apt-get update
RUN apt-get -y install apt-utils dialog libterm-readline-perl-perl && apt-get clean
RUN apt-get -y install libgmp3-dev libsigsegv-dev && apt-get clean
RUN apt-get -y install openssl libssl-dev && apt-get clean
RUN apt-get -y install libncurses5-dev git && apt-get clean
RUN apt-get -y install make exuberant-ctags && apt-get clean
RUN git clone https://github.com/urbit/urbit.git && rm -r /urbit/.git
RUN apt-get -y install gcc && apt-get clean
RUN cd /urbit && make
RUN echo '#!/usr/bin/env bash\nexport URBIT_HOME=/urbit/urb\ncd /urbit\nif [ ! -d pier ]; then bin/vere -c pier; else bin/vere pier; fi' >/.urbinit
RUN echo 'source $HOME/.profile' >/.bashrc
RUN echo 'export URBIT_HOME=/urbit/urb' >/.profile
RUN chmod +x /.urbinit
CMD ['/.urbinit']
