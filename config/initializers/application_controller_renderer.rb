# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

Naver.configure do |config|
  config.client_id     = "qEsB5TG58sTiUyIYO7DK"
  config.client_secret = "Un8QamdoGi"
  config.redirect_uri  = "https://openapi.naver.com/v1/search/book"
  config.timeout = 10
  config.debug = false
end