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
  haml :index, locals: { lines: parks, body_data: index_body_data }
end

get '/:park_name' do
  park = Parks.by_path(params[:park_name])

  if park.nil?
    downcased_park = params[:park_name].downcase
    park = Parks.by_path(downcased_park)
    return redirect to("/#{downcased_park}")
  end

  haml :show, locals: { park: park, body_data: show_body_data }
end

def park_data(park)
  return {} unless park
  {
    lat: park['Latitude'],
    lng: park['Longitude'],
    title: park['Name'],
    underscored_title: park['underscored_title']
  }
end

def index_body_data
 {
   parks: JSON.dump(Parks.all.map {|park| park_data(park)})
 }
end

def show_body_data
  park = Parks.by_path(params[:park_name])
  { park: park_data(park) }
end
