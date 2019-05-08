class TopController < ApplicationController
  def index
  end

  def terms
  end

  def privacy
  end

  def company
  end


  def bad_request
    raise ActionController::ParameterMissing, ""
  end

  def forbidden
    raise Forbidden, ""
  end

  def internal_server_error
    raise
  end
end
