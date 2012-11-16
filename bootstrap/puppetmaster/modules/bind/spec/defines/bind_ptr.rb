require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::ptr', :type => :define do

  let(:title) { '42.42' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::ptr standard usage' do
    let(:params) { {
        :zone   => '42.42.in-addr.arpa',
        :target => 'server.example42.com.',
    } }
    it { should contain_bind__record('PTR-42.42').with_zone('42.42.in-addr.arpa') }
    it { should contain_bind__record('PTR-42.42').with_target('server.example42.com.') }
    it { should contain_bind__record('PTR-42.42').with_record_type('PTR') }
    it { should contain_bind__record('PTR-42.42').with_order('70') }
  end

  describe 'Test bind::ptr with different order' do
    let(:params) { {
        :zone  => '42.42.in-addr.arpa',
        :target => 'server.example42.com.',
        :order => '42',
    } }
    it { should contain_bind__record('PTR-42.42').with_order('42') }
  end
end

