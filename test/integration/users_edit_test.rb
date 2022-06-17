require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
    def setup

    end
    test "unsuccessful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
    end
end