require_relative 'settings'

module SimplePassport; end
class SimplePassport::Passport < Struct.new(:user_key, :time, :salt, :signature)
  class << self
    def build_signature(user_key, time, salt)
      Digest::SHA512.hexdigest("#{SimplePassport::Settings.secret_key}#{user_key}#{time}#{salt}")
    end

    def issue_for(user_key)
      time = Time.now.to_i
      salt = SecureRandom.hex(SimplePassport::Settings.salt_length)
      new(user_key, time, salt, build_signature(user_key, time, salt)).encode
    end

    def from_hash(as_hash)
      new(
        as_hash['user_key'],
        as_hash['time'],
        as_hash['salt'],
        as_hash['signature'],
      )
    end

    def read_from(as_base64)
      as_json = Base64.decode64(as_base64)
      as_hash = JSON.parse(as_json) rescue nil
      from_hash(as_hash) if as_hash
    end
  end

  def encode
    Base64.encode64(to_hash.to_json).gsub(/\n/, '')
  end

  def valid?
    time.is_a?(Integer) &&
    (Time.now.to_i - time <= SimplePassport::Settings.passport_lifetime) &&
    signature == self.class.build_signature(user_key, time, salt)
  end

  def to_hash
    {'user_key' => user_key, 'time' => time, 'salt' => salt, 'signature' => signature}
  end
end
