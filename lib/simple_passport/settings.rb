require_relative 'authorization_error'

module SimplePassport; end
module SimplePassport::Settings
  mattr_accessor :passport_lifetime, :salt_length

  def self.get_setting(key_name, default = nil)
    ENV.fetch("simple_passport_#{key_name}".upcase) { default }
  end

  @@passport_lifetime = get_setting(:passport_lifetime, 30).to_i.seconds
  @@salt_length = get_setting(:salt_length, 16).to_i

  def self.secret_key(suffix = nil)
    key_name = 'secret_key'
    key_name += '_' + suffix.to_s if suffix.present?
    key = get_setting(key_name)
    raise SimplePassport::AuthorizationError.new("Can't use SimplePassport with blank key!") if key.blank?
    key
  end
end
