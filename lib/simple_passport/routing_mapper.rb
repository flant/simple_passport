module SimplePassport
  module RoutingMapper

    def passport_authorization(path, params={})
      post path, params
    end

  end
end

if defined? ActionDispatch::Routing::Mapper
  ActionDispatch::Routing::Mapper.class_eval do
    include SimplePassport::RoutingMapper
  end
end
