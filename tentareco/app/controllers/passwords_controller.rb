class PasswordsController < ApplicationController
  before_action :login_required

  def show
    redirect_to :account
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    a_c_p = password_params[:current_password]
  
    if a_c_p.present?
      if @user.authenticate(a_c_p)
      @user.assign_attributes(password_params)
        if @user.save
         redirect_to :account, notice: "パスワードを変更しました。"
        else
          render "edit"
       end
     else
        @user.errors.add(:current_password, :wrong)
       render "edit"
     end
    else
     @user.errors.add(:current_password, :empty)
      render "edit"
   end
  end

  private def password_params
    params.require(:password).permit(
      :current_password,
      :password,
      :password_confirmation
    )
  end
end
