FROM yebyen/urbinit:src-i686
RUN cd /urbit && git pull && make clean && make -j3
ADD ./_urbinit /.urbinit
RUN ln -s /root/.urbit /.urbit && mkdir /root/.urbit
RUN echo 'source $HOME/.profile' >/.bashrc && echo 'export URBIT_HOME=/urbit/urb' >/.profile && echo 'LANG=en_US.UTF-8' > /etc/default/locale
CMD ["/.urbinit"]
