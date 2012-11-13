# Installing Puppet
gem install puppet -v 2.7.18 --no-ri --no-rdoc
/usr/bin/puppet master --mkusers --debug --verbose

# Clear out any crusty SSL directories
rm -rf /etc/puppet/ssl
