FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y git python-dev libffi-dev gcc libssl-dev python-selinux python-setuptools openssh-client vim

RUN apt-get install -y python-pip
RUN pip install ansible==2.9.10

RUN mkdir -p /etc/kolla

RUN mkdir -p /etc/ansible && echo "[defaults]\nhost_key_checking=False\npipelining=True\nforks=100\n" > /etc/ansible/ansible.cfg

WORKDIR  /opt/

RUN git clone https://github.com/ceph/ceph-ansible.git && cd ceph-ansible && git checkout stable-5.0

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

## Ceph configs
RUN cp /opt/ceph-ansible/site.yml.sample /opt/ceph-ansible/site.yml


WORKDIR /opt/ceph-ansible/

ENTRYPOINT ["/docker-entrypoint.sh"]
