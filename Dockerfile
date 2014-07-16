FROM yebyen/urbinit:src
RUN cd /urbit && git pull && make clean && make distclean all -j5
ADD ./_urbinit /.urbinit
RUN echo 'source $HOME/.profile' >/.bashrc && echo 'export URBIT_HOME=/urbit/urb' >/.profile && echo 'LANG=en_US.UTF-8' > /etc/default/locale
CMD ["/.urbinit"]
