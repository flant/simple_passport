# frozen_string_literal: true

require 'action_controller/railtie'
require 'rails/engine'

require_relative 'simple_passport/version'
require_relative 'simple_passport/engine'
require_relative 'simple_passport/authorization_controller'
require_relative 'simple_passport/routing_mapper'
require_relative 'simple_passport/passport'

module SimplePassport
  def self.issue_for(user_key)
    Passport.issue_for(user_key)
  end

  def self.read_from(str)
    Passport.read_from(str)
  end
end
