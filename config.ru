require_relative 'config/environment'

use Rack::RequestId
use Rack::Ougai::LogRequests, Application.logger

map '/api' do
  run AdRoutes
end
