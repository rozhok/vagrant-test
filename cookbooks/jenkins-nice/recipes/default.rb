include_recipe 'java::default'
include_recipe 'jenkins::master'

jenkins_plugins = %w(
  mailer
  credentials
  ssh-credentials
)
jenkins_plugins.each do |plugin|
  jenkins_plugin plugin do
    notifies :execute, 'jenkins_command[safe-restart]', :immediately
  end
end

jenkins_command 'safe-restart' do
  action :nothing
end

jenkins_user 'admin' do
  password 'Passw0rd'
end

template 'xml' do
  source 'config.xml.erb'
end

# Create a jenkins job (default action is `:create`)
jenkins_job 'vagrant-test' do
  config 'xml'
end