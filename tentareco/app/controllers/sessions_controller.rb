class SessionsController < ApplicationController
  def new
  end

  def create
    user_obj = User.find_by(name: params[:name])
    
    if user_obj&.authenticate(params[:password])
      session[:user_id] = user_obj.id
      redirect_to :root
    else
      flash.alert = "名前とパスワードが一致しません。"
      redirect_to :new_session
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end 
end
