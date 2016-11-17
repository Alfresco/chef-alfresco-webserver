require 'spec_helper'

RSpec.describe 'alfresco-webserver::start' do
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

  it 'should include the alfresco-webserver::nginx-start recipe by default' do
    expect(chef_run).to include_recipe('alfresco-webserver::nginx-start')
  end
end
