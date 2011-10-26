class ApplicationController < ActionController::Base
  protect_from_forgery
  FB_APP_ID = "130302083739638"
  FB_APP_SECRET = "f4887cf5a51186b37c59748624e5792b"

  before_filter :set_locale
  
  def set_locale
    I18n.locale = request.compatible_language_from(
      FbGh::Application.config.available_locales
    )
  end
  
  def fb_client
    FbGraph::Auth.new(FB_APP_ID, FB_APP_SECRET).client
  end
end
