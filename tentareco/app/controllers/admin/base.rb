class Admin::Base < ApplicationController
  before_action :admin_login_requiired

  private def admin_login_requiired
    raise Forbidden unless current_user&.administrator?
  end
end