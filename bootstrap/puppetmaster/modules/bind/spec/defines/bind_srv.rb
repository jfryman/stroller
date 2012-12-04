require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::srv', :type => :define do

  let(:title) { '_http._tcp' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::srv standard usage' do
    let(:params) { {
        :zone        => 'example42.com',
        :target      => 'server',
        :record_port => '42',
    } }
    it { should contain_bind__record('SRV-_http._tcp').with_zone('example42.com') }
    it { should contain_bind__record('SRV-_http._tcp').with_target('server') }
    it { should contain_bind__record('SRV-_http._tcp').with_record_type('SRV') }
    it { should contain_bind__record('SRV-_http._tcp').with_order('20') }
    it { should contain_bind__record('SRV-_http._tcp').with_record_priority('0 0 42') }
  end

  describe 'Test bind::srv with different record priority and weight' do
    let(:params) { {
        :zone            => 'example42.com',
        :target          => 'server',
        :record_port     => '42',
        :record_priority => '43',
        :record_weight   => '44',
    } }
    it { should contain_bind__record('SRV-_http._tcp').with_record_priority('43 44 42') }
  end

  describe 'Test bind::srv with different order' do
    let(:params) { {
        :zone  => 'example42.com',
        :target      => 'server',
        :record_port => '42',
        :order => '42',
    } }
    it { should contain_bind__record('SRV-_http._tcp').with_order('42') }
  end
end

