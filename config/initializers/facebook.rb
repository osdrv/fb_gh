FB_APP_ID = "130302083739638"
FB_APP_SECRET = "06611fffa4a27ddd268f9bb9c1b5a4f3"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_APP_ID, FB_APP_SECRET, {
    :scope => 'email, read_stream, status_update, publish_stream, read_friendlists, create_event, publish_actions, user_interests, user_groups, user_events, user_education_history, user_activities, user_online_presence, user_work_history'
  }
end