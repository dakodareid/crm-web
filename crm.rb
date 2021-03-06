require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

# $rolodex= Rolodex.new
# $rolodex.add_contact(Contact.new("Dakoda", "Reid", "Dakoda@gmail.com", "none"))

get '/' do 
	@crm_app_name = "My CRM"
	erb :index
end

get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get '/contacts/new' do
	erb :contacts_new
end

get '/contacts/search' do
	erb :contacts_search
end

post '/contacts/search' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    erb :contact_not_found
  end
end

# contact = $rolodex.find(1000)

# post '/contacts' do
# 	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
# 	$rolodex.add_contact(new_contact)
# 	redirect to('/contacts')
# end

post '/contacts' do 
  contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
    )
  redirect to('/contacts')
end


get '/contacts/edit' do
	erb :edit_contact
end

post '/contacts/mod' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact_page
  else
    erb :contact_not_found
  end
end

put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    @contact.save
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/delete' do
	erb :delete_who
end

delete "/contacts/remove" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    erb :contact_not_found
  end
end
