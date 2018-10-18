haproxy_install 'package'

haproxy_config_defaults 'defaults' do
  mode 'http'
  timeout connect: '5000ms',
          client: '5000ms',
          server: '5000ms'
  haproxy_retries 5
  balance 'roundrobin'
end

haproxy_backend 'servers' do
  server [
             'apache-blue 192.168.100.101 check port 80 weight 1 maxconn 128',
             'apache-green 192.168.100.102 check port 80 weight 1 maxconn 128'
         ]
end

haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'servers'
end

haproxy_service 'haproxy'
