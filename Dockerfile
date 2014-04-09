FROM yebyen/urbinit-base
RUN git clone https://github.com/urbit/urbit 
RUN apt-get -y install gcc && apt-get clean
RUN cd /urbit && make
ADD ./_urbinit /.urbinit
RUN ln -s /root/.urbit /.urbit
RUN echo 'source $HOME/.profile' >/.bashrc
RUN echo 'export URBIT_HOME=/urbit/urb' >/.profile
CMD ["/.urbinit"]
CMD ["screen", "/.urbinit"]
