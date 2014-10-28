require_relative 'contact'
require 'sinatra'

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do
	@contacts = []
	@contacts << Contact.new("Dakoda", "Reid", "Dakoda@gmail.com", "no-notes")
	@contacts << Contact.new("Makoda", "Seed", "Makoda@gmail.com", "no-notes")
	@contacts << Contact.new("Fadoda", "Peed", "Fadoda@gmail.com", "no-notes")

	er :contacts

end

get '/contacts/new' do
	erb :contacts
end