FROM yebyen/urbinit-base
RUN apt-get -y install mercurial texinfo && apt-get clean
RUN hg clone https://re2.googlecode.com/hg re2
RUN apt-get -y install gcc g++ && apt-get clean
RUN cd /re2 && make && make install
RUN ldconfig
RUN apt-get -y install libtool && apt-get clean
RUN apt-get -y install autoconf automake && apt-get clean
