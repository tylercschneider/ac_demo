class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def require_auth
    token = request.headers["Authorization"].to_s[/\ABearer (.+)\z/, 1]
    @current_user = User.find_by(api_token: token) if token
    head :unauthorized unless @current_user
  end
end
