# config valid only for current version of Capistrano
# lock '3.8.0'

set :application, 'readfavor'
set :repo_url, 'git@bitbucket.org:readmatters/readmatters.git'

set :rails_env, 'production'

set :linked_dirs, %w{log tmp/cache tmp/sockets tmp/pids}

# rbenv
set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.3.0'      # Defaults to: 'default'
set :rvm_custom_path, '/usr/local/rvm/'

# capistrano-rails
set :keep_assets, 1

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/application.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

#puma config
set :puma_threads, [1, 2]
set :puma_workers, 1

set :nginx_sites_available_path, "/usr/local/nginx/sites-available"
set :nginx_sites_enabled_path, "/usr/local/nginx/sites-enabled"
