# chef-alfresco-webserver

This cookbook will install the WebServer part of the Alfresco stack.
The default choice is NginX, but it can be expanded to use your own webserver.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>default['webserver']['engine']</tt></td>
    <td>String</td>
    <td>Engine of choice</td>
    <td><tt>nginx</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['port']</tt></td>
    <td>Int</td>
    <td>Webserver public port</td>
    <td><tt>80</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['port_ssl']</tt></td>
    <td>Int</td>
    <td>Public SSL Port</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['protocol']</tt></td>
    <td>String</td>
    <td>Default protocol to use</td>
    <td><tt>https</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['hostname']</tt></td>
    <td>String</td>
    <td>Machine hostname</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['lb_hostname']</tt></td>
    <td>String</td>
    <td>Hostname/Address of the internal load-balancer</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['lb_protocol']</tt></td>
    <td>String</td>
    <td>Protocol used to talk to the internal load-balancer</td>
    <td><tt>http</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['lb_port']</tt></td>
    <td>Int</td>
    <td>Port of the internal load-balancer</td>
    <td><tt>9001</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['use_nossl_config']</tt></td>
    <td>Boolean</td>
    <td>Whether to avoid or use ssl</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['certs']['filename']</tt></td>
    <td>String</td>
    <td>SSL cert filename</td>
    <td><tt>alfresco</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['certs']['ssl_folder']</tt></td>
    <td>String</td>
    <td>folder where the SSL certs will be stored</td>
    <td><tt>/etc/pki/tls/certs'</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['error_pages']['error_folder']</tt></td>
    <td>String</td>
    <td>folder where the error pages will be stored</td>
    <td><tt>/var/www/html/error_pages</tt></td>
  </tr>
  <tr>
    <td><tt>default['webserver']['harden']</tt></td>
    <td>Boolean</td>
    <td>wheter you want this installation to be hardened or not</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

Include this cookbook in your Berksfile:
```
cookbook 'alfresco-webserver', git:'https://github.com/Alfresco/chef-alfresco-webserver', tag: 'v0.7.0'
cookbook 'nginx-hardening', git: 'https://github.com/dev-sec/chef-nginx-hardening' (only if you want hardening)
```
And add it's reference inside your `metadata.rb` file:

```
depends 'alfresco-webserver'
depends 'nginx-hardening' (only if you want hardening)
```


### chef-alfresco-webserver::default

The cookbook is divided in 2 recipes:

- `alfresco-webserver::default` will install and upgrade the webserver of your choice ( specified under the `default['webserver']['engine']` attribute)
- `alfresco-webserver::start` will configure and start the webserver to accept external connections and pass the information to the internal load-balancer.

Include `alfresco-webserver` in your node `run_list`:

```json
{
  "run_list": [
    "recipe[alfresco-webserver::default]",
    "recipe[alfresco-webserver::start]"
  ]
}
```

## License and Authors

Author:: Enzo Rivello (<enzo.rivello@alfresco.com>)
