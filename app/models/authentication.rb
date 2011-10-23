class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  
  field :token
  field :provider
  field :uid

  scope :provided, ->(provider) { where(:provider => provider) }
  scope :uided, ->(uid) { where(:uid => uid) }
  
  class << self
    def find_by_provider_and_uid(provider, uid)
      self.provided(provider).uided(uid).first
    end
  end
end
