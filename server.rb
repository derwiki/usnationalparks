# require 'dotenv'
# Dotenv.load

require 'sinatra'
require 'haml'
require 'json'
# require 'active_support/core_ext/hash'
# require 'active_support/core_ext/string'
require_relative 'lib/parks'

get '/' do
  parks = Parks.all
  haml :index, locals: { lines: parks, body_data: body_data }
end

def body_data
 {
   parks: 
     JSON.dump(Parks.all.map do |park|
       {
        lat: park['Latitude'],
        lng: park['Longitude'],
        title: park['Name'],
        underscored_title: park['underscored_title']
       }
     end
   )
 }
end
