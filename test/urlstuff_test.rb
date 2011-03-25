require 'test/unit'
require '../lib/urlstuff'
	
class UrlStuffTest < Test::Unit::TestCase
	include UrlStuff
	def setup
		@empty_url = ''
		@invalid_file_url = 'http://example.com/'
		@normal_file_url = 'http://example.com/text.txt'
		@no_ext_url = 'http://example.com/CSDj35'
	end
	
	def test_get_name
		assert_equal('text.txt', get_name(@normal_file_url))
		assert_equal('CSDj35.pdf', get_name(@no_ext_url))
		assert_raise (RuntimeError) {get_name(@empty_url)}
		assert_raise (RuntimeError) {get_name(@invalid_file_url)}
	end	
end