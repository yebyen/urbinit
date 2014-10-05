FROM yebyen/urbinit:src-amd64
RUN cd /urbit && git pull && make clean && make distclean all
ADD ./_urbinit /.urbinit
RUN echo 'source $HOME/.profile' >/.bashrc && echo 'LANG=en_US.UTF-8' > /etc/default/locale
CMD ["/.urbinit"]
