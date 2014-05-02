FROM yebyen/urbinit:source
RUN cd /urbit && git pull && make
ADD ./_urbinit /.urbinit
RUN ln -s /root/.urbit /.urbit
RUN echo 'source $HOME/.profile' >/.bashrc
RUN echo 'export URBIT_HOME=/urbit/urb' >/.profile
CMD ["/.urbinit"]
