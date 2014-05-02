FROM yebyen/trusty
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install apt-utils dialog libterm-readline-perl-perl \
                        libgmp3-dev libsigsegv-dev \
                        openssl libssl-dev \
                        libncurses5-dev git \
                        make exuberant-ctags \
                        wget screen tmux unzip \
                        gcc g++ && apt-get clean
