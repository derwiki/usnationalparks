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

    def by_path(title)
      all.find {|park| park['underscored_title'] == title}
    end
  end
end
