set :rails_env, 'production'

set :host, ENV['host']

host = fetch(:host) || ask(:host, '', echo: true)
server host, user: 'api-repofs', roles: %w{app db web}