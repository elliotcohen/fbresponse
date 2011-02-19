class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  API_VERSION = '2010-04-01'

  # Twilio AccountSid and AuthToken
  ACCOUNT_SID = 'ACc940e73cf3c65d37de962d29bcd53f9e'
  ACCOUNT_TOKEN = '2b6a5c4a0121f30d7a86b4ec33339f6b'

  # Outgoing Caller ID previously validated with Twilio
  CALLER_ID = '4124179460';

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

  def self.send_text(number, message)
      #send a text message
    # Create a Twilio REST account object using your Twilio account ID and token
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

    # ===========================================================================
    # 1. Initiate a new outbound call to 415-555-1212
    #    uses a HTTP POST
    d = {
        'From' => CALLER_ID,
        'To' => '4124179460',
        'Url' => 'http://smooth-meadow-728.heroku.com/twillio',
    }
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
        'POST', d)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    puts "code: %s\nbody: %s" % [resp.code, resp.body]
  end
end
