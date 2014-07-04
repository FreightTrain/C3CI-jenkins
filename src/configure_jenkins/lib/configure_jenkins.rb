#!/var/vcap/packages/ruby/bin/ruby

require 'daemons'
require 'time'
require 'net/http'

require_relative './configurator'

include Daemons

pid_dir = "/var/vcap/sys/run/jenkins_master/"
log_dir = "/var/vcap/sys/log/jenkins_master/"
plugins_conf = "/var/vcap/jobs/jenkins_master/config/jenkins_plugins.conf"

# daemon options
options = {
  :backtrace  => true,
  :monitor    => false,
  :dir    => pid_dir,
  :log_dir => log_dir,
  :log_output => true,
}

def jenkins_available?
  Net::HTTP.get_response('localhost', '/').code.to_i == 200
end

Daemons.run_proc("configure_jenkins.rb",options) do
  loop do
    unless jenkins_available?

      $stderr.puts  Time.now.utc.iso8601 + ' Jenkins not available'
      sleep 10 and exit! 1
    end
    space_separated_plugins = File.readlines(plugins_conf).first
    jenkins = Jenkins::Configurator.new({:plugins => space_separated_plugins.split(' ')})
    jenkins.configure
    sleep 60
  end
end
