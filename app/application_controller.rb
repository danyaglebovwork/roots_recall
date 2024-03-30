class ApplicationController < ActionController::Base
  protected def authenticate!
    access_denied!(message: "Нет доступа!") unless authenticated?
  end

  protected def authenticated?
    current_session.present?
  end

  protected def access_denied!(message: nil)
    raise Errors::AccessDenied, message || "Нет доступа!"
  end

  protected def current_session
    @current_session ||= self.session
  end

  protected def current_owner
    @current_owner ||= User.find_by(id: current_session[:user_id])
  end
end
