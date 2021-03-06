# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'ps6'
set :repo_url, 'ssh://git@vgl-ait.org/web14-02.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
 set :deploy_to, '/home/deployer/ps6'
# set :bundle_gemfile, -> { File.join(release_path,fetch(:application),'Gemfile') }

# Set up a strategy to deploy only a project directory (not the whole repo)
 set :git_strategy, RemoteCacheWithProjectRootStrategy
 set :project_root, 'ps6'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Precompile Asset'
  task :precompile do
    on roles(:app), in: :sequence, wait: 5 do
      within "#{current_path}/#{fetch(:application)}" do
        with rails_env: :production do
          execute :rake, "assets:precompile"
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute "mkdir -p #{current_path}/tmp"
      info "create folder #{current_path}/tmp"
      execute :touch, File.join(release_path,'/tmp/restart.txt')
    end
  end

  after :publishing , :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
