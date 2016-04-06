require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Proz < OmniAuth::Strategies::OAuth2

      DEFAULT_SCOPE = 'user.email'

      option :name, :proz

      option :client_options, {
        :site => 'https://www.proz.com',
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      }

      option :authorize_options, [:scope]

      uid { raw_info['uuid'] }

      info do
        {
          :email => raw_info["email"],
          :name  => raw_info["site_name"],
          :profile_url  => raw_info["profile_url"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.proz.com/v2/user').parsed
      end

      def authorize_params
        super.tap do |params|
          %w[scope].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end

          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      protected

      def build_access_token
        params = {
          'client_id' => client.id,
          'client_secret' => client.secret,
          'code' => request.params['code'],
          'grant_type' => 'authorization_code',
          'redirect_uri' => options[:callback_url]
          }.merge(token_params.to_hash(symbolize_keys: true))
        client.get_token(params, deep_symbolize(options.auth_token_params))
      end

    end
  end
end