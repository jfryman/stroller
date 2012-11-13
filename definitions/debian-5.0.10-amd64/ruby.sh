#Installing ruby
apt-get -y install ruby ruby1.8-dev libopenssl-ruby1.8 rdoc ri irb make g++ libshadow-ruby1.8

# Install Rubygems from source
rg_ver=1.8.24

curl -o /tmp/rubygems-${rg_ver}.zip \
  "http://production.cf.rubygems.org/rubygems/rubygems-${rg_ver}.zip"
(cd /tmp && unzip rubygems-${rg_ver}.zip && \
  cd rubygems-${rg_ver} && ruby setup.rb --no-format-executable)
rm -rf /tmp/rubygems-${rg_ver} /tmp/rubygems-${rg_ver}.zip
