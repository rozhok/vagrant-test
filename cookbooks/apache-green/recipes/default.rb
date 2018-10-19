include_recipe 'apache2'
apache_site 'default'

template 'index.html' do
  path '/var/www/index.html'

  owner node['apache']['user']
  group node['apache']['group']

  variables(text: 'I am server 2')
end

web_app 'apache-green' do
  server_name '192.168.100.103'
  docroot '/var/www'
end