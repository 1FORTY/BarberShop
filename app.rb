require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'haml'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	hash = {
		username: "Введите имя",
		phone: "Введите телефон",
		datetime: "Введите дату и время"
	}

	hash.each do |key, value|
		if params[key] == ''
			@error = hash[key]

			return erb :visit
		end
	end


	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"

end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	email = params[:email]
	body = params[:body]
	name = params[:name]

	if email == ''
		error = 'Вы не ввели email'
		return erb :contacts
	elsif email.include?('@') != true
		email = 'Вы не верную почту'
		return erb :contacts
	else
		erb "Сообщение отправлено"
	end

	Pony.mail(
		:name => params[:name],
	 	:mail => params[:mail],
		:body => params[:body],
		:to => 'wanya.game@gmail.com',
		:subject => params[:name] + " has contacted you",
		:port => '587',
		:enable_starttls_auto => true,
		:user_name => 'Vanya',
		:password => 'g.Barnaul',
		:authentication => :plain,
		:domain => 'localhost.localdomain'
	)
end
