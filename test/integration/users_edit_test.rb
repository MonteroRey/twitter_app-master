require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:rey)
    end
    test "unsuccessful edit" do
        get edit_user_path(@user)
        assert_template 'users/edit'
        patch use_path(@user), params: { user: {name: "",
                                         password: "foo",
                                         password_confirmation: "bar" }}
        assert_template 'users/edit'
    end
end