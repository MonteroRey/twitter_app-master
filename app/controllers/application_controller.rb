class ApplicationController < ActionController::Base
    # def hello 
    #     render html: "hello, world!"
    # end
    include SessionsHelper
    
  ############################ access deny redirect to log-in path #####################
#   def check_if_logged_in
#     deny_access unless logged_in?
    
#   end
end
