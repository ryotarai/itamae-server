#!/bin/bash
rm -rf /tmp/consul
consul agent -config-file /vagrant/config.json -bind $(ip addr show eth1 | grep 'inet ' | grep -o -E '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -n1)
