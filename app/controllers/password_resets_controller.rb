class PasswordResetsController < ApplicationController
  def new

  end

  def create 
    @user = User.find_by(email: params[:password_resets])
  end

  def edit
  end
end
