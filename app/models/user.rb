class User
  REGISTERED_USERS = {
    'user1@example.com' => 'password1',
    'user2@example.com' => 'password2',
    'user3@example.com' => 'password3',
  }

  attr_reader :id, :identity_key, :password
  def initialize(identity_key)
    @id           = SecureRandom.uuid
    @identity_key = identity_key
    @password     = REGISTERED_USERS[identity_key]
  end

  def valid_password?(pass)
    return false unless pass.present?
    return false unless pass == password

    true
  end

  class << self
    def find_by(identity_key:)
      new(identity_key) if registered?(identity_key)
    end

    private

    def registered?(identity_key)
      REGISTERED_USERS.keys.include? identity_key
    end
  end
end
