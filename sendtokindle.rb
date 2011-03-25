require 'sinatra/base'
require 'open-uri'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

class SendToKindle < Sinatra::Base
	include EmailStuff
	set :public, './public/'
	
	helpers do
		# Provide a file name from the file url
		def get_name(url)
			name = url.scan(/[^\/]*$/)[0]
			if name=~/\./
				name
			else
				name + '.pdf'
			end
		end
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
			send_email(@url, @email)
			erb :send
		end
	end
end
