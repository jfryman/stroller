require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::aaaa', :type => :define do

  let(:title) { 'server' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::aaaa standard usage' do
    let(:params) { {
        :zone   => 'example42.com',
        :target => '4242:4242:4242:4242:4242:4242:4242:4242',
    } }
    it { should contain_bind__record('AAAA-server').with_zone('example42.com') }
    it { should contain_bind__record('AAAA-server').with_target('4242:4242:4242:4242:4242:4242:4242:4242') }
    it { should contain_bind__record('AAAA-server').with_record_type('AAAA') }
    it { should contain_bind__record('AAAA-server').with_order('50') }
  end

  describe 'Test bind::aaaa with different order' do
    let(:params) { {
        :zone  => 'example42.com',
        :target => '4242:4242:4242:4242:4242:4242:4242:4242',
        :order => '42',
    } }
    it { should contain_bind__record('AAAA-server').with_order('42') }
  end
end

