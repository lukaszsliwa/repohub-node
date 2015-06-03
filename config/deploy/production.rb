set :rails_env, 'production'

set :host, ENV['host']

server fetch(:host), user: 'api-repofs', roles: %w{app db web}