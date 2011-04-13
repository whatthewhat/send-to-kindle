require 'sinatra/base'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

class SendToKindle < Sinatra::Base
	include EmailStuff
	include UrlStuff
	
	set :public, './public/'

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
			send_email(@url, @email)
			erb :send
		end
	end
	
	error do
		"Sorry, something went wrong..."
	end
end
