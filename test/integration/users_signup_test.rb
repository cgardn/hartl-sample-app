require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                          email: "user@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post signup_path, params: {user: { name: "Integration Test User",
                                         email: "good@email.com",
                                         password: "testpassword",
                                         password_confirmation: "testpassword" } }
    end
    follow_redirect!
#    assert_template 'users/show'
#    assert is_logged_in?
    assert_not flash.empty?

  end
end
