require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::txt', :type => :define do

  let(:title) { 'my_record' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::txt standard usage' do
    let(:params) { {
        :zone   => 'example42.com',
        :target => 'My message',
    } }
    it { should contain_bind__record('TXT-my_record').with_zone('example42.com') }
    it { should contain_bind__record('TXT-my_record').with_target('My message') }
    it { should contain_bind__record('TXT-my_record').with_record_type('TXT') }
    it { should contain_bind__record('TXT-my_record').with_order('30') }
  end

  describe 'Test bind::txt with different order' do
    let(:params) { {
        :zone  => 'example42.com',
        :target => 'My message',
        :order => '42',
    } }
    it { should contain_bind__record('TXT-my_record').with_order('42') }
  end
end

