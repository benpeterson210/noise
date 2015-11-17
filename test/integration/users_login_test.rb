require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
 
	def setup
		@user = users(:benjamin)
	end

	test "login with valid information followed by logout" do
		get login_path
		post login_path, session: { email: @user.email, password: 'password' }
		assert is_logged_in? #defined in test_helper
		assert_redirected_to @user
		follow_redirect! #band command actually goes and stays on user's page
		assert_template 'users/show'
		assert_select "a[href=?]", login_path, count: 0 
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(@user)
		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path,       count: 0
		assert_select "a[href=?]", user_path(@user),  count: 0
	end



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
