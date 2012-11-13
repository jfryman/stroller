# Install Puppet
gem install puppet -v 2.7.18 --no-ri --no-rdoc
/usr/bin/puppet master --mkusers --debug --verbose

# Install Dependencies for Puppet
apt-get -y install 'libaugeas-ruby1.8'
