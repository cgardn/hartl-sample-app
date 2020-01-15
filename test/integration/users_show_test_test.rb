require 'test_helper'

class UsersShowTestTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @nonactive = users(:nonactive)
  end

  test "edit page should not exist for non-activated users" do
    log_in_as(@admin)
    get user_path(@nonactive)
    assert_redirected_to root_url
    follow_redirect!
    assert_template '/'
  end

end
