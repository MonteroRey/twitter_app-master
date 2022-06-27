class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  before_action :valid_user , only: [:edit , :update]
  before_action :check_expiration , only: [:edit , :update]
  def new

  end

  def create 
    byebug
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info]="Email sent with password reset instructions"
      redirect_to root_url
    else 
      flash.now[:danger]= "Email address not found"
      render 'new'
    end
  end

  def edit
  end
  def update 
    byebug
    if params[:user][:password].empty? 
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif
      log_in @user 
      byebug
      @user.update_attribute(:reset_digest, nil)
      flash[:success]= "Password has been reset"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private 
  def get_user
    byebug
    @user= User.find_by(email: params[:email])
  end

  #Confirm a valid user
  def valid_user
    byebug
    unless(@user && @user.activated? && @user.authenticated?(:reset , params[:id]))
      redirect_to @user #root_url
    end
  end

  def check_expiration 
    byebug
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

end
