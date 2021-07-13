class SessionsController < ApplicationController


  def login

  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to restaurants_path
    else
      flash[:errors] = ["Invalid Username or Password!"]
      redirect_to login_path
    end
  end


  def logout
    session.clear
    redirect_to new_user_path
  end

end
