require 'csv'

class Parks
  class << self
    def all
      return @parks if @parks

      parks = []
      CSV.foreach(File.open('data/parks.csv'), headers: true).each do |line|
        parks << line.to_hash
      end
      @parks = parks
    end
  end
end
