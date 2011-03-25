require 'open-uri'

module UrlStuff
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