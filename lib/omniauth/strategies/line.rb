require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Line < OmniAuth::Strategies::OAuth2
      option :name, "line"

      option :client_options, {
        site: "https://access.line.me",
        authorize_url: "/oauth2/v2.1/authorize",
        token_url: "https://api.line.me/oauth2/v2.1/token"
      }

      option :scope, "profile openid"

      uid { raw_info["userId"] }

      info do
        {
          name: raw_info["displayName"],
          image: raw_info["pictureUrl"],
          description: raw_info["statusMessage"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("https://api.line.me/v2/profile").parsed
      end

      def callback_url
        if Rails.env.development?
          "http://localhost:3000#{script_name}#{callback_path}"
        else
          full_host + script_name + callback_path
        end
      end
    end
  end
end
