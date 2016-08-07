require_relative "../parks"

def search(park_name)
  `echo q | googler/googler -C --count 10 #{park_name} national park maps site:nps.gov`
end

def search_all
  File.open("data/map-sites.csv", "w+") do |f|
    Parks.all.map do |park|
      r = search(park['Name'])
      map_url = r.split("\n").grep(/http.*maps.*/).first
      puts map_url
      f.write("#{map_url}\n")
    end
  end
end

search_all
