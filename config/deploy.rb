set :application, "jara"
set :repository,  "git://github.com/ayoshimiya/jara.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "drablaz.dyndns.org"                          # Your HTTP server, Apache/etc
role :app, "drablaz.dyndns.org"                          # This may be the same as your `Web` server
role :db,  "drablaz.dyndns.org", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

set :port, 7532
set :deploy_to, "/home/fitter/jara"
set :user, "fitter"
set :use_sudo, false

#Agent forwarding can make key management much simpler as it uses your local keys instead of keys installed on the server.
ssh_options[:"forward_agent"] = true

# enable this to pull only recent changes... otherwise full clone is issued
set :deploy_via, :remote_cache
set :branch, "master"

# rvm capistrano plugin integration
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                               # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.3-p0@jara'                  # Should be equal to $PROJECT_HOME/.rvmrc ;)
set :rvm_type, :user                                   # Copy the exact line. I really mean :user here
