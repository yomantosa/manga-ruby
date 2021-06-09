class UsersController < ApplicationController


    def index
        @users = User.all.order("created_at DESC")
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
  
        if @user.save
            redirect_to @user
        else
            render 'new'
        end
    end

    def my_posts
        user = User.find(params[:user_id])
        @posts = user.posts.order("created_at DESC")
    end

    def show
        @user = User.find(params[:id])
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
  
        redirect_to users_path
  
    end


    private
  
    def user_params
        params.fetch(:user, {}).permit(:name, :email, :password, :password_confirmation)
    end

end
