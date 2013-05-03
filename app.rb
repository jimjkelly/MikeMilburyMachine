# This one time we must load the environment specifically,
# and it will take care of amending the load path elsewhere.
require File.dirname(__FILE__) + '/environment.rb'

set :raise_errors, false
set :show_exceptions, false

error do
  e = request.env['sinatra.error']
  puts e.to_s
  puts e.backtrace.join("\n")
  "Application Error!"
end

helpers do
  def authorized?
    session[:auth] && session[:auth]['secret'] == ENV['OAUTH_TOKEN_SECRET']
  end

  def link(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
  
  def host
    request.env['HTTP_HOST']
  end
  
  def url(path = '')
    "#{scheme ||= 'http'}://#{host}#{path}"
  end
end

get '/' do
  @lawls = getlawls()
  erb :index
end

get '/signin' do
  erb :signin
end

get '/auth/twitter/callback' do
  session[:auth] = request.env['omniauth.auth']['credentials']

  if authorized?
    redirect '/submit'
  else
    redirect '/signin'
  end 
end

get '/submit' do
  if authorized?
    erb :submit
  else
    redirect '/signin'
  end
end

post '/submit' do
  if authorized?
    addlawl(params[:quote], params[:douche], params[:link], params[:ovi])
    erb :submit
  else
    redirect '/signin'
  end
end