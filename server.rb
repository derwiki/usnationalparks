# require 'dotenv'
# Dotenv.load

require 'csv'
require 'sinatra'
require 'haml'
# require 'json'
# require 'active_support/core_ext/hash'
# require 'active_support/core_ext/string'

get '/' do
  lines = []
  CSV.foreach(File.open('data/parks.csv'), headers: true).each do |line|
    lines << line.to_hash
  end


  haml :index, locals: { lines: lines }
end

