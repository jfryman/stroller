require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::wildcard', :type => :define do

  let(:title) { 'example42.com' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::wildcard standard usage' do
    let(:params) { {
        :zone   => 'example42.com',
        :target => '42.42.42.42',
    } }
    it { should contain_bind__record('wildcard-example42.com').with_zone('example42.com') }
    it { should contain_bind__record('wildcard-example42.com').with_target('42.42.42.42') }
    it { should contain_bind__record('wildcard-example42.com').with_order('999999') }
  end

  describe 'Test bind::wildcard without zone' do
    let(:params) { {
      :target => '42.42.42.42',
    } }
    it { should contain_bind__record('wildcard-example42.com').with_zone('example42.com') }
    it { should contain_bind__record('wildcard-example42.com').with_target('42.42.42.42') }
  end

  describe 'Test bind::wildcard with different order' do
    let(:params) { {
      :target => '42.42.42.42',
      :order => '42',
    } }
    it { should contain_bind__record('wildcard-example42.com').with_order('42') }
  end
end

