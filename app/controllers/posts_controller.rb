class PostsController < ApplicationController 
    before_action :logged_in_user ,  only: [:create , :destroy]
    before_action :correct_user , only: :destroy

    def create 
        byebug
        @post = current_user.posts.build(post_params)
        @post.image.attach(params[:post][:image])
        if @post.save
            flash[:success]= "Post Created"
            redirect_to root_url
        else
            byebug
            @feed_items = current_user.feed.paginate(page: params[:page])
            flash[:danger] = @post.errors.full_messages.to_sentence
            render 'static_pages/home'
        end
    end

    def  destroy 
        @post.destroy 
        flash[:success] = "Post/Tweet deleted"
        redirect_to request.referrer || root_url
    end


    private
    def post_params
        params.require(:post).permit(:content, :image) 
    end

    def correct_user
        byebug
        @post = current_user.posts.find_by(id: params[:id])
        redirect_to root_url if @post.nil?
    end

end
