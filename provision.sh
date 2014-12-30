#!/bin/bash

yum install -y ruby
gem install puppet
rm -rf /etc/puppet/modules/stdlib
/usr/local/bin/puppet module install puppetlabs/stdlib
