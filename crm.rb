require 'sinatra'
require_relative 'rolodex'
require_relative 'contact'

@@rolodex= Rolodex.new
@@rolodex.add_contact(Contact.new("Dakoda", "Reid", "Dakoda@gmail.com", "none"))

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do
	erb :contacts
end

get '/contacts/new' do
	erb :contacts_new
end

get '/contact/1000' do
	@contact = @@rolodex.find(1000)
	erb :show_contact
end

contact = @@rolodex.find(1000)

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
	
end
