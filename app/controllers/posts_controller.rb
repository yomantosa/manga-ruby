class PostsController < ApplicationController
    
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :require_author, only: [:edit, :update, :destroy]

    def index
        @posts = Post.all.order("created_at DESC")
    end
  
    def new
        @post = Post.new
    end
  
    def create
        @post = Post.new(post_params)
        @post.user = current_user
    
        respond_to do |format|
            if @post.save
                format.html { redirect_to @post}
                format.json { render :show, status: :created, location: @post }
            else
                format.html { render :new }
                format.json { render json: @post.errors, status: :unprocessable_entity }
             end
        end
    end
  
    def require_author
        redirect_to(@post) unless @post.user == current_user
    end

    def set_post
        @post = Post.find(params[:id])
    end

    def show
        @post = Post.find(params[:id])
    end
  
    def update
        @post = Post.find(params[:id])
  
        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end
  
    def edit
        @post = Post.find(params[:id])
    end
  
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
  
    private
  
    def post_params
        params.require(:post).permit(:title, :user_id, :author, :content, images: [])
    end
end
