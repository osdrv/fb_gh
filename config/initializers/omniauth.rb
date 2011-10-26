FB_APP_ID = "130302083739638"
FB_APP_SECRET = "f4887cf5a51186b37c59748624e5792b"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_APP_ID, FB_APP_SECRET, :scope => "read_stream, publish_stream, create_event, publish_actions, user_events, user_education_history, user_activities, user_work_history"
end