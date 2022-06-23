require 'test_helper'

class SessionsHelpertest <ActionView::TestCase 
    def setup
        @user = users(:rey)
        remember(@user)
    end

    test "current_user returns right  user when ses" do 
        assert_email @user, current_user
        assert is_logged_in?
    end
end