class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :danger
  def not_found
   raise ActionController::RoutingError.new('Not Found')
 rescue
   render_404
  end

 def render_404
   render file: "#{Rails.root}/public/404", status: :not_found
 end
end
