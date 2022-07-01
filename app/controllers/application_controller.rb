class ApplicationController < ActionController::Base
    # def hello 
    #     render html: "hello, world!"
    # end
    include SessionsHelper
    
  ############################ access deny redirect to log-in path #####################
#   def check_if_logged_in
#     deny_access unless logged_in?
    
#   end

    private
    def logged_in_user 
      #byebug
      unless logged_in?
        store_location
        flash[:danger]="Please log in" 
        redirect_to login_url
      end
    end
end
