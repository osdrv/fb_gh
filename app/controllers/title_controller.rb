require "base64"
require "json"

class TitleController < ApplicationController

  def welcome
    if !user_signed_in?
      user_data = parse_signed_request(params[:signed_request])["data"] rescue nil
      client = fb_client
      redirect_to client.authorization_uri(
        :scope => %w(read_stream publish_stream create_event publish_actions user_events user_education_history user_activities user_work_history).map(&:to_sym)
      ) if user_data.nil?
      fb_user = FbGraph::User.me((user_data["oauth_token"] rescue nil)).fetch.as_json
      user = User.find_or_initialize_by(:uid => fb_user["identifier"], :provider => "facebook")
      user.update_attributes(:user_info => fb_user.except(%w(identifier)))
      sign_in user
    end
    
    redirect_to user_url
  end
  
private
  
  def handle_unverified_request
    true
  end
  
  # translated from FB php sdk one
  def parse_signed_request(signed_request)
    encoded_sig, payload = signed_request.split(/\./)
    JSON.parse("{ \"data\": #{base64_url_decode(payload)} }") rescue nil
  end
  
  def base64_url_decode(str)
    Base64.decode64(str.tr("-_", "+/"))
  end
  
end
