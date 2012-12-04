require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bind::mx', :type => :define do

  let(:title) { 'mail.example42.com' }
  let(:node) { 'rspec.example42.com' }

  describe 'Test bind::mx standard usage' do
    let(:params) { {
        :zone   => 'example42.com',
    } }
    it { should contain_bind__record('MX-mail.example42.com').with_zone('example42.com') }
    it { should contain_bind__record('MX-mail.example42.com').with_target('mail.example42.com') }
    it { should contain_bind__record('MX-mail.example42.com').with_record_type('MX') }
    it { should contain_bind__record('MX-mail.example42.com').with_order('10') }
  end

  describe 'Test bind::mx with different order' do
    let(:params) { {
        :zone  => 'example42.com',
        :order => '42',
    } }
    it { should contain_bind__record('MX-mail.example42.com').with_order('42') }
  end
end

