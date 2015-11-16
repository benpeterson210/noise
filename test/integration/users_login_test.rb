require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
 
	test 'flash should go away after bad login' do 
		get login_path
		assert_template 'sessions/new'
		post login_path, session: { email: "user@example.com", password: ""}
		assert_template 'sessions/new'
		assert_not flash.empty?
		get about_path
		assert flash.empty?
		
	end

end
