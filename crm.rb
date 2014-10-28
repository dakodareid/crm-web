require 'sinatra'
require_relative 'rolodex'
require_relative 'contact'

$rolodex= Rolodex.new

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do
	erb :contacts
end

get '/contacts/new' do
	erb :contacts
end