# frozen_string_literal: true

app_path = File.expand_path('../../../', __FILE__)
api_directory = '/api'

worker_processes 2

working_directory "#{app_path}#{api_directory}"
listen "#{app_path}#{api_directory}/tmp/sockets/unicorn.sock"
pid "#{app_path}#{api_directory}/tmp/pids/unicorn.pid"
stderr_path "#{app_path}#{api_directory}/log/unicorn.stderr.log"
stdout_path "#{app_path}#{api_directory}/log/unicorn.stdout.log"

listen 3001
timeout 300

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end