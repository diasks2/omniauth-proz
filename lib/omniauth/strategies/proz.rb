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
        @raw_info ||= access_token.get('https://api.proz.com/v2/user').parsed
      end

      protected
      def build_access_token
        params = {
          'client_id' => client.id,
          'client_secret' => client.secret,
          'code' => request.params['code'],
          'grant_type' => 'authorization_code',
          'redirect_uri' => 'http://localhost:3000/translators/auth/proz/callback'
          }.merge(token_params.to_hash(symbolize_keys: true))
        client.get_token(params, deep_symbolize(options.auth_token_params))
      end

    end
  end
end