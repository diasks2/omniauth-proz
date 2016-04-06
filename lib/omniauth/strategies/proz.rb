require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Proz < OmniAuth::Strategies::OAuth2

      option :name, :proz

      option :client_options, {
        :site => 'https://www.proz.com',
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      }

      uid { raw_info['uuid'] }

      info do
        {
          :email => raw_info["email"],
          :name  => raw_info["site_name"],
          :profile_url  => raw_info["profile_url"]
        }
      end

      def raw_info
        puts "Get Raw Info"
        @raw_info ||= access_token.get('https://api.proz.com/v2/user.json').parsed
      end

      protected
      def build_access_token
        puts "REQUEST: #{request.inspect}"
        params = {
          'appid' => client.id,
          'secret' => client.secret,
          'code' => request.params['code'],
          'grant_type' => 'authorization_code'
          }.merge(token_params.to_hash(symbolize_keys: true))
        puts "PARAMS: #{params}"
        client.get_token(params, deep_symbolize(options.auth_token_params))
      end

    end
  end
end