FROM yebyen/urbinit:src-i686
RUN cd /urbit && git pull && make -j3
ADD ./_urbinit /.urbinit
RUN ln -s /root/.urbit /.urbit
RUN echo 'source $HOME/.profile' >/.bashrc
RUN echo 'export URBIT_HOME=/urbit/urb' >/.profile
CMD ["/.urbinit"]
