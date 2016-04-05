require "pry"
require "json"
require "etsiest/version"
require "sinatra/base"
require "uri"

require "etsy"

Etsy.api_key = ENV["ETSY_KEY"]
# <%= results %>

module Etsiest
  class App < Sinatra::Application
    get '/search' do
      query = params["q"]
      #maybe have if for missing "q"?
      # response = Etsy.search_thing(response)
      response = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'],
          :keywords => query)

      binding.pry
      erb :index, locals: {results: response.result}
    end
    run! if app_file == $0
  end
end
