class PostsController < ApplicationController 
    before_action :logged_in_user ,  only: [:create , :destroy]
    before_action :correct_user , only: :destroy

    def create 
        byebug
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success]= "Post Created"
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end

    def  destroy 
        byebug
        @post.destroy 
        flash[:success] = "Post/Tweet deleted"
        redirect_to request.referrer || root_url
    end


    private
    def post_params
        params.require(:post).permit(:content) 
    end

    def correct_user
        byebug
        @micropost = current_user.posts.find_by(id: params[:id])
        redirect_to root_url if @post.nil?
    end

end
