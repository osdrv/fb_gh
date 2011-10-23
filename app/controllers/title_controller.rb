class TitleController < ApplicationController
  def welcome
    if user_signed_in?
      redirect_to user_url
    else
      redirect_to "/auth/facebook"
    end
  end
end
