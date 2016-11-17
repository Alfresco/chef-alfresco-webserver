require 'spec_helper'

RSpec.describe 'alfresco-webserver::nginx' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '7.2.1511',
      file_cache_path: '/var/chef/cache'
    ) do |node|
    end.converge(described_recipe)
  end

  before do
    stub_command('which nginx').and_return('')
    stub_command('which semanage').and_return('')
    stub_command('semanage permissive -l | grep httpd_t').and_return('')
    stub_command('semanage port -a -t http_port_t -p tcp 2100').and_return('')
    stub_command('getenforce | grep -i enforcing').and_return('')
    stub_command('semanage port -l | grep 2100').and_return('')
  end

  it 'should include the nginx hardening upgrades recipe' do
    expect(chef_run).to include_recipe('nginx-hardening::upgrades')
  end

  it 'should delete the default.conf file' do
    expect(chef_run).to delete_file('/etc/nginx/conf.d/default.conf')
  end

  it 'should include the nginx::repo recipe' do
    expect(chef_run).to include_recipe('nginx::repo')
  end

  it 'should include the nginx::default recipe' do
    expect(chef_run).to include_recipe('nginx::repo')
  end
end
