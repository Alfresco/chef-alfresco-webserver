require 'spec_helper'

RSpec.describe 'chef-alfresco-webserver::nginx-conf' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '7.2.1511',
      file_cache_path: '/var/chef/cache'
    ) do |node|
    end.converge(described_recipe)
  end

  it 'should include the nginx::commons_conf recipe' do
    expect(chef_run).to include_recipe('nginx::commons_conf')
  end
end
