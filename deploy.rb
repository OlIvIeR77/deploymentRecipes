require "bundler/capistrano"
require "rvm/capistrano"

load "config/recipes/base"
load "config/recipes/node"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/mysql"
load "config/recipes/rvm"

server "blogolivierdo.no-ip.org", :web, :app, :db, primary: true

set :site_url, "blogolivierdo.no-ip.org"
set :application, "blog"
set :user, "deployer"

set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false

set :shared_children, shared_children + %w{public/uploads}

set :scm, "git"
set :repository,  "https://github.com/OlIvIeR77/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

#default_run_options[:shell] = '/bin/bash --login'

after "deploy", "deploy:cleanup" # keep only the last 5 releases

