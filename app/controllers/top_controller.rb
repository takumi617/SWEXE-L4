class TopController < ApplicationController
    def main
        if session[:login_uid] != nil
            render "main"
        else
            render "login"
        end
    end
    
    def login
        u = User.find_by(uid: params[:uid])
        if u != nil and BCrypt::Password.new(u.pass) == params[:pass]
            session[:login_uid] = params[:uid]
            redirect_to top_main_path
        else
            render "error", status: 422
        end
    end
    
    def logout
        session.delete(:login_uid)
        redirect_to top_main_path
    end
end
