require 'omniauth/strategies/oauth2'
require 'openssl'
require 'rack/utils'
require 'uri'

module OmniAuth
  module Strategies
    class Eventpop < OmniAuth::Strategies::OAuth2
      class NoAuthorizationCodeError < StandardError; end

      DEFAULT_SCOPE = ''

      option :name, 'eventpop'

      option :client_options, {
        site: 'https://www.eventpop.me/api/public',
        authorize_url: 'https://www.eventpop.me/oauth/authorize',
        token_url: 'https://www.eventpop.me/oauth/token'
      }

      option :authorize_options, [:scope, :display, :auth_type]

      uid { raw_info['user']['id'] }

      info do
        prune!({
          'email' => raw_info['user']['email'],
          'name' => raw_info['user']['full_name']
        })
      end

      extra do
        hash = {}
        hash['raw_info'] = raw_info unless skip_info?
        prune! hash
      end

      def raw_info
        @raw_info ||= access_token.get('/api/public/me').parsed || {}
      end

      protected

      def build_access_token
        verifier = request.params["code"]
        client.auth_code.get_token(verifier, {:redirect_uri => callback_url}.merge(token_params.to_hash(symbolize_keys: true)), deep_symbolize(options.auth_token_params))
      end

      private

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end
