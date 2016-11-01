class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    
    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "Account was successfully updated"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    
    def show
    end
    
    def destroy
        @user.destroy
        flash[:danger] = "Sorry to see you go! Account was successfully deleted"
        redirect_to articles_path
    end
    
    private
    def set_user
            @user = User.find(params[:id])
    end
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end