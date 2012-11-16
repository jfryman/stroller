require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::a', :type => :define do

  let(:title) { 'server' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::a standard usage' do
    let(:params) { {
        :zone   => 'example42.com',
        :target => '42.42.42.42',
    } }
    it { should contain_bind__record('A-server').with_zone('example42.com') }
    it { should contain_bind__record('A-server').with_target('42.42.42.42') }
    it { should contain_bind__record('A-server').with_record_type('A') }
    it { should contain_bind__record('A-server').with_order('40') }
  end

  describe 'Test bind::a with different order' do
    let(:params) { {
        :zone  => 'example42.com',
        :target => '42.42.42.42',
        :order => '42',
    } }
    it { should contain_bind__record('A-server').with_order('42') }
  end
end

