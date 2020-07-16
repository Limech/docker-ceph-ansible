#!/bin/bash

cmd="$1"

add_hosts() {

for hostname in `sort out_stream.txt`
do
    #extract hostnames from hosts file
    ip=`grep -i $hostname.local /etc/hosts | awk '{print $1}'`
    echo "--add-host=${hostname}:${ip}"
done

}


docker run --rm -it $(add_hosts) -e UID=$(id -u) -e GID=$(id -g) -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub  -v ${PWD}/ceph/all.yml:/opt/ceph-ansible/group_vars/all.yml -v ${PWD}/inventory:/opt/ceph-ansible/inventory ceph:test $cmd
