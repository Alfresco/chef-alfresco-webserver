describe package('nginx') do
  it { should be_installed }
end

control '01' do
  impact 0.7
  title 'Verify nginx service'
  desc 'Ensures nginx service is up and running'
  describe service('nginx') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

describe port(80) do
  it { should be_listening }
  its('processes') { should include(/nginx/) }
end

web_user = 'www-data'
web_user = 'nginx' if os[:family] == 'redhat'

describe user(web_user) do
  it { should exist }
end
