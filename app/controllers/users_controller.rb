class UsersController < ApplicationController
    before_action :require_no_user!

    def create
        @user = User.new(user_params)
        if @user.save
            session[:session_token] = @user.reset_session_token!
            redirect_to cats_url
        else
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def user_params
        params.require(:user).permit(:password, :username)
    end
end