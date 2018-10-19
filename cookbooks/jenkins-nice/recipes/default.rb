include_recipe 'java::default'
include_recipe 'jenkins::master'

plugins = {
    'ace-editor' => '1.1',
    'apache-httpcomponents-client-4-api' => '4.5.5-3.0',
    'authentication-tokens' => '1.3',
    'bouncycastle-api' => '2.17',
    'branch-api' => '2.0.20',
    'cloudbees-folder' => '6.6',
    'command-launcher' => '1.2',
    'config-file-provider' => '3.3',
    'credentials' => '2.1.18',
    'credentials-binding' => '1.16',
    'display-url-api' => '2.2.0',
    'docker-commons' => '1.13',
    'docker-workflow' => '1.17',
    'durable-task' => '1.26',
    'git-client' => '2.7.3',
    'git-server' => '1.7',
    'handlebars' => '1.1.1',
    'jackson2-api' => '2.8.11.3',
    'jdk-tool' => '1.1',
    'jquery-detached' => '1.2.1',
    'jsch' => '0.1.54.2',
    'junit' => '1.26.1',
    'lockable-resources' => '2.3',
    'mailer' => '1.21',
    'matrix-project' => '1.13',
    'momentjs' => '1.1.1',
    'pipeline-build-step' => '2.7',
    'pipeline-graph-analysis' => '1.7',
    'pipeline-input-step' => '2.8',
    'pipeline-milestone-step' => '1.3.1',
    'pipeline-model-api' => '1.3.2',
    'pipeline-model-declarative-agent' => '1.1.1',
    'pipeline-model-definition' => '1.3.2',
    'pipeline-model-extensions' => '1.3.2',
    'pipeline-multibranch-defaults' => '2.0',
    'pipeline-rest-api' => '2.10',
    'pipeline-stage-step' => '2.3',
    'pipeline-stage-tags-metadata' => '1.3.2',
    'pipeline-stage-view' => '2.10',
    'plain-credentials' => '1.4',
    'scm-api' => '2.3.0',
    'script-security' => '1.47',
    'ssh-credentials' => '1.14',
    'structs' => '1.17',
    'token-macro' => '2.5',
    'workflow-aggregator' => '2.6',
    'workflow-api' => '2.30',
    'workflow-basic-steps' => '2.11',
    'workflow-cps' => '2.59',
    'workflow-cps-global-lib' => '2.12',
    'workflow-durable-task-step' => '2.22',
    'workflow-job' => '2.26',
    'workflow-multibranch' => '2.20',
    'workflow-scm-step' => '2.7',
    'workflow-step-api' => '2.16',
    'workflow-support' => '2.21'
}

plugins.each_with_index do |(plugin_name, plugin_version), index|
  jenkins_plugin plugin_name do
    action  :install
    version plugin_version
    install_deps false
    # only restart on the final plugin
    if index == (plugins.size - 1)
      notifies :restart, 'service[jenkins]', :immediately
    end
  end
end

xml = File.join(Chef::Config[:file_cache_path], 'vagrant-test-config.xml')

template xml do
  source 'config.xml.erb'
end

jenkins_job 'vagrant-test' do
  config xml
end
