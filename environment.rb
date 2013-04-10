# Add the current directory to the load path
$:.unshift File.dirname(__FILE__)
require 'mongo_hash'
require 'db/models'
require 'sinatra'
require 'bundler'
require 'logger'
require 'mongo'
require 'uri'

Bundler.setup
Bundler.require


configure :development do
  unless ENV['MONGO_URL_DEV']
    raise "Must set MONGO_URL_DEV environment variable prior to running"
  end
end

configure :production do
  unless ENV['MONGOHQ_URL']
    raise "Must set MONGOHQ_URL environment variable prior to running"
  end
end