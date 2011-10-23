class AuthController < ApplicationController
  include AuthHelper
  
  def welcome
    p params
    p base64_url_decode(params[:signed_request])
  end

  def create
    p params
    render :status => 200, :text => ""
  end
end
