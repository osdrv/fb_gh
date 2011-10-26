class AuthenticationsController < ApplicationController # < InheritedResources::Base
  #actions :index, :create, :destroy
  
  def create
    client = fb_client
    #omniauth = request.env["omniauth.auth"]
    #Rails.logger.debug(omniauth)
    client.authorization_code = params[:code]
    Rails.logger.debug params[:code]
    access_token = client.access_token!  # => Rack::OAuth2::AccessToken
    user = FbGraph::User.me(access_token).fetch
    p user
    render :status => 200, :text => ""
    
    
    
    # omniauth = request.env["omniauth.auth"]
    # Rails.logger.debug(omniauth)
    # authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    # Rails.logger.debug(authentication)
    # if authentication
    #   flash[:notice] = "Signed in successfully."
    #   sign_in_and_redirect(:user, authentication.user)
    # elsif current_user
    #   current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => (omniauth['credentials']['token'] rescue nil))
    #   flash[:notice] = "Authentication successful."
    #   redirect_to user_url
    # else
    #   user = User.find_or_initialize_by(:email => (omniauth["user_info"]["email"] rescue nil))
    #   user.apply_omniauth(omniauth)
    #   if user.save
    #     flash[:notice] = "Signed in successfully."
    #     sign_in_and_redirect(:user, user)
    #   else
    #     Rails.logger.debug(user.errors.to_json)
    #     session[:omniauth] = omniauth
    #     redirect_to new_user_registration_url
    #   end
    # end
  end
  
  def failure
    render :status => 200, :text => "Something broken : ("
  end
  
  private
  
  def collection
    p "asdfasdfasdf"
    @authentications ||= current_user.authentications
  end
  
  # def handle_unverified_request
  #   true
  # end
  
end
