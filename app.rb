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

get '/submit' do
  erb :submit
end

post '/submit' do
  addlawl(params[:quote], params[:douche], params[:link], params[:ovi])
  erb :submit
end