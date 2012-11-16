require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::cname', :type => :define do

  let(:title) { 'server' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::cname standard usage' do
    let(:params) { {
        :zone   => 'example42.com',
        :target => 'server2',
    } }
    it { should contain_bind__record('CNAME-server').with_zone('example42.com') }
    it { should contain_bind__record('CNAME-server').with_target('server2') }
    it { should contain_bind__record('CNAME-server').with_record_type('CNAME') }
    it { should contain_bind__record('CNAME-server').with_order('60') }
  end

  describe 'Test bind::cname with different order' do
    let(:params) { {
        :zone  => 'example42.com',
        :target => 'server2',
        :order => '42',
    } }
    it { should contain_bind__record('CNAME-server').with_order('42') }
  end
end

