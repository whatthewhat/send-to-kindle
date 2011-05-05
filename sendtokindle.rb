require 'yaml'
require 'sinatra/base'
require './lib/emailer.rb'

class SendToKindle < Sinatra::Base
  
  configure do  
    email_config = YAML.load_file("config/email.yml")
    @@emailer = Emailer.new(email_config)
    
    set :public, './public/'
  end	
	
  get '/' do

		erb :index
	end

	get '/send' do
		@url = params[:url]
		@email = params[:email]
				
		if @url.empty? || @email.empty?
			redirect '/'
		else
			@email = @email.chomp + '@free.kindle.com' unless @email=~/@/
			@@emailer.send_email(@url, @email)
			erb :send
		end
	end
	
	error do
		"Sorry, something went wrong..."
	end
end
