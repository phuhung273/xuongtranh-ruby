
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://phuhung273.github.io', 'http://localhost:9528'
    resource '*', headers: :any, methods: :any
  end
end
