class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :user_info, :type => Hash
  field :user_hash, :type => Hash
  
  has_many :authentications
  after_update lambda { authentications.map(&:save) }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'facebook'
      self.apply_facebook(omniauth)
    end
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token =>(omniauth['credentials']['token'] rescue nil))
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.provided('facebook').first.token)
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
      self.user_hash = extra
    end
    if (user_info = omniauth["user_info"] rescue false)
      self.user_info = user_info
    end
  end
end
