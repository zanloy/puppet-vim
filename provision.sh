#!/bin/bash

rm -rf /etc/puppet/modules/concat
puppet module install puppetlabs/concat
rm -rf /etc/puppet/modules/stdlib
puppet module install puppetlabs/stdlib
rm -rf /etc/puppet/modules/wget
puppet module install maestrodev/wget
