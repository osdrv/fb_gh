FB_APP_ID = "130302083739638"
FB_APP_SECRET = "06611fffa4a27ddd268f9bb9c1b5a4f3"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_APP_ID, FB_APP_SECRET
end