class UsersController < InheritedResources::Base
  actions :show, :update
  
private

  def resource
    current_user
  end
end
