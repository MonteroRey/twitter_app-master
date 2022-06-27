class UsersController < ApplicationController
  
  #before_action :check_if_logged_in, only: [:show, :edit, :update, :delete] ################# deny access
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :current_user, only: [:edit, :update]
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    byebug
    @posts =@user.posts.paginate(page: params[:page])
  end
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    byebug
    if @user.save
      UserMailer.account_activation(@user).deliver_now                  #log_in @user
      flash[:success] = "Please check your email to activate your account"
      byebug
      redirect_to root_url
    else
      render 'new'
    end
  end
  

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user 
    else
      render 'edit'
    end
  end
  ######### delete users #########################
  def destroy
    User.find(params[:id]).destroy 
    flash[:success] = "User deleted"
    redirect_to users_url
  end
################ relocated to Application controller ##############
  # def logged_in_user
  #   unless logged_in?
  #     store_location
  #     flash[:danger]="Please log in"
  #     redirect_to login_url
  #   end
  # end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  ################ confirms an admin user
  def admin_user  
    redirect_to(root_url) unless current_user.admin?
  end
end
