FROM ubuntu:latest
RUN apt-get update && apt-get install -y openssh-server
RUN echo 'root:none' | chpasswd
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >>/etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

