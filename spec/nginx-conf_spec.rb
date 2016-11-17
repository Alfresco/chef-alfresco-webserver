require 'spec_helper'

RSpec.describe 'alfresco-webserver::nginx-conf' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '7.2.1511',
      file_cache_path: '/var/chef/cache'
    ) do |node|
    end.converge(described_recipe)
  end

  before do
    stub_command("find /etc/nginx -perm -o+r -type f -o -perm -o+w -type f | wc -l | egrep '^0$'").and_return('')
  end

  it 'should include the nginx::commons_conf recipe' do
    expect(chef_run).to include_recipe('nginx::commons_conf')
  end

  it 'should include the nginx-hardening::default recipe by default' do
    expect(chef_run).to include_recipe('nginx-hardening::default')
  end

  it 'should enable nginx' do
    expect(chef_run).to enable_service('nginx')
  end

  it 'should start nginx' do
    expect(chef_run).to start_service('nginx')
  end
end
