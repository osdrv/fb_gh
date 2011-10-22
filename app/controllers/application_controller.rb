class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  def set_locale
    I18n.locale = request.compatible_language_from(
      FbGh::Application.config.available_locales
    )
  end
end
