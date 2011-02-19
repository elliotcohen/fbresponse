class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def self.find_for_facebook_oauth(data_hash, signed_in_resource=nil)
    data = data_hash['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      if data_hash['credentials']['token'] != user.access_token
        user.access_token = data_hash['credentials']['token']
        user.save
      end
      user
    else
      nil
    end
  end

end
