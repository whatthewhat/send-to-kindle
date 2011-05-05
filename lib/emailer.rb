require 'pony'
require './lib/urlstuff.rb'

class Emailer
  include UrlStuff
  
  def initialize(email_config)
    @email_config = email_config
  end
  
	# Download the file and send it to the appropriate address
  def send_email(url, email)
    file = open(url).read
    filename = get_name(url)
		Pony.mail(:to => email,
      :from => 'Send To Kindle',
		  :subject => 'Convert',
		  :attachments => {filename => file},
		  :via => :smtp, 
      :via_options => @email_config
      )   
	end
end