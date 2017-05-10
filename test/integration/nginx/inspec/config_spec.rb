nginx_conf = '/etc/nginx/nginx.conf'

options = {
  assignment_re: /^\s*([^:]*?)\s*\ \s*(.*?)\s*;$/,
}

control 'nginx-11' do
  impact 0.2
  title 'Custom Alfresco NginX configuration'
  desc 'Configuration checks to be sure that we are following the reference architecture schema'

  # NginX should point to the internal load balancer, in the same machine and at the port 9001 as default
  describe parse_config_file(nginx_conf, options) do
    its('proxy_pass') { should eq 'http://127.0.0.1:9001' }
  end

  describe parse_config_file(nginx_conf, options) do
    its('listen') { should eq '80' }
    its('server_name') { should eq '127.0.0.1' }
  end
end
