require_relative 'authorization_error'

module SimplePassport; end
module SimplePassport::Settings
  mattr_accessor :passport_lifetime, :salt_length

  def self.get_setting(key, default = nil)
    ENV.fetch("simple_passport_#{key}".upcase) { default }
  end

  @@passport_lifetime = get_setting(:passport_lifetime, 30).to_i.seconds
  @@salt_length = get_setting(:salt_length, 16).to_i

  def self.secret_key
    key = get_setting(:secret_key)
    raise SimplePassport::AuthorizationError.new("Can't use SimplePassport with blank key!") if key.blank?
    key
  end
end
