class Admin::UsersController < Admin::Base
  #ユーザー一覧表示機能
  def index
    @users = User.order(created_at: :desc)
    #@users = User.all
  end

  #検索機能
  def search
    @users = User.search(params[:q])
    render "index"
  end

  #詳細表示機能
  def show
    @user = User.find(params[:id])
  end

  #新規ユーザー登録（前段階）
  def new
    @user = User.new
  end

  #編集機能
  def edit
    @user = User.find(params[:id])
  end

  #新規ユーザー登録
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to [:admin, @user], notice: "ユーザー登録が完了しました。"
    else
      render "new"
    end
  end

  #ユーザー情報の更新
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to [:admin, @user], notice: "ユーザー情報を更新しました。"
    else
      render "edit"
    end
  end

  #ユーザーの削除
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :admin_users, notice: "ユーザーを削除しました。"
  end

  private def user_params
    attrs =[
      :new_profile_picture,
      :remove_profile_picture,
      :name,
      :full_name,
      :email,
      :administrator
    ]
    attrs << :password if params[:action] == "create"
    attrs << :password_confirmation if params[:action] == "create"
    params.require(:user).permit(attrs)
  end
end