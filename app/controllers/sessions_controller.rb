class SessionsController < ApplicationController
    before_action :require_no_user!, only: %i(create new)


    def new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if user.nil?
            render :new
        else
            session[:session_token] = user.reset_session_token!
            redirect_to cats_url
        end
    end

    def destroy
        user = current_user
        if user
            user.reset_session_token!
            session[:session_token] = nil
            redirect_to new_session_url
        else
            redirect_to new_session_url
        end

    end
end