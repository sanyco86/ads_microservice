require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'kaminari'
require 'kaminari/config'
require 'kaminari/helpers/paginator'
require 'kaminari/models/page_scope_methods'
require 'kaminari/models/configuration_methods'
require './app/helpers/pagination_links.rb'
require 'json'
require 'fast_jsonapi'

include ::PaginationLinks

Dir["./app/models/*.rb"].each(&method(:require))
Dir["./app/serializers/*.rb"].each(&method(:require))
Dir["./app/services/*.rb"].each(&method(:require))

class Application < Sinatra::Base
  set :show_exceptions, false
end

get '/ads' do
  ads = Ad.order(updated_at: :desc).page(params[:page])
  serializer = AdSerializer.new(ads, links: pagination_links(ads))

  serializer.serializable_hash
end

post '/ads' do
  result = CreateService.new(params).call

  if result.success?
    serializer = AdSerializer.new(result.ad)
    serializer.serializable_hash
  else
    halt 422, result.errors
  end
end
