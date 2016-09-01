module SimplePassport; end
module SimplePassport::Settings
  mattr_accessor :passport_lifetime, :salt_length, :secret_key_path

  def self.get_setting(key, default = nil)
    ENV.fetch("simple_passport_#{key}".upcase) { default }
  end

  @@passport_lifetime = get_setting(:passport_lifetime, 30.seconds)
  @@salt_length = get_setting(:salt_length, 16)

  def self.secret_key
    File.read(get_setting(:secret_key_path))
  end
end
