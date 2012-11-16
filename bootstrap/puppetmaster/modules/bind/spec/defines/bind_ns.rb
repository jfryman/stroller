
require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::ns', :type => :define do

  let(:title) { 'ns.example42.com' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::ns standard usage' do
    let(:params) { {
        :zone   => 'example42.com',
    } }
    it { should contain_bind__record('NS-ns.example42.com').with_zone('example42.com') }
    it { should contain_bind__record('NS-ns.example42.com').with_target('ns.example42.com') }
    it { should contain_bind__record('NS-ns.example42.com').with_record_type('NS') }
    it { should contain_bind__record('NS-ns.example42.com').with_order('0') }
  end

  describe 'Test bind::ns with different order' do
    let(:params) { {
        :zone  => 'example42.com',
        :order => '42',
    } }
    it { should contain_bind__record('NS-ns.example42.com').with_order('42') }
  end

end

