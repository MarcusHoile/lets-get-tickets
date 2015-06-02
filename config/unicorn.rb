root = "/var/www/planndit/current"
working_directory root
pid "/var/www/planndit/shared/pids/unicorn.pid"
stderr_path "/var/www/planndit/shared/log/unicorn.log"
stdout_path "/var/www/planndit/shared/log/unicorn.log"

listen "/var/www/planndit/current/tmp/unicorn.planndit.sock"
worker_processes 4
timeout 30

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end