require 'rest-client'
require 'json'
require 'active_support'

module TelegramBot
  module Request
    class PrependMethods
      attr_accessor :token

      def initialize(*args, token:, &block)
        @token = token
        super(*args, &block)
      end
    end

    API_BASE = 'https://api.telegram.org/bot'

    def self.included(clazz)
      clazz.prepend PrependMethods
    end

    def request(method, params)
      url  = construct_url(method)
      resp = RestClient.post(url, params)
      return JONS.parse(resp.body) if resp.code.to_s =~ /^2\d\d$/
      raise Exception.new(resp)
    end

    private

    def construct_url(method)
      method_camelized = method.to_s.camelize(:lower)
      "#{API_BASE}#{@token}/#{method_camelized}"
    end
  end
end
