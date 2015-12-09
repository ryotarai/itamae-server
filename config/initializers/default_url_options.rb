Rails.application.routes.default_url_options[:host] = Figaro.env.default_host
Rails.application.routes.default_url_options[:port] = Figaro.env.default_port
