require_relative 'authorization_error'
require_relative 'passport'

module SimplePassport; end
module SimplePassport::AuthorizationController
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user_passport
    before_action :validate_passport

    rescue_from SimplePassport::AuthorizationError do |exc|
      render plain: {error: 'Authorization failed'}.to_json, content_type: 'application/json', status: 401
    end
  end

  protected

  def validate_passport
    return true if params[:passport] &&
                     (@current_user_passport = SimplePassport::read_from(params[:passport])) &&
                     current_user_passport.valid?(simple_passport_secret_key_name)
    raise SimplePassport::AuthorizationError.new('Invalid Passport')
  end
end

if defined? ActionController::Base
  ActionController::API.class_eval do
    def self.passport_authorization_controller(kwargs = {})
      define_method :simple_passport_secret_key_name do
        kwargs[:key]
      end

      include SimplePassport::AuthorizationController
    end
  end
end
