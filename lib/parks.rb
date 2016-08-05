require 'csv'

class Parks
  class << self
    def all
      return @parks if @parks

      parks = []
      CSV.foreach(File.open('data/parks.csv'), headers: true).each do |line|
        park_hash = line.to_hash
        park_hash['underscored_title'] = park_hash['Name'].downcase.gsub(/ /, ?_)
        parks << park_hash
      end

      @parks = parks
    end
  end
end
