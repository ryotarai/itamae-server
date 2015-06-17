case ENV['AUTH_PROVIDER']
when 'google_oauth2'
  Rails.application.config.middleware.use OmniAuth::Builder do
    options = {}
    if hd = ENV["GOOGLE_HOSTED_DOMAIN"]
      options[:hd] = hd
    end
    provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], options
  end
end
