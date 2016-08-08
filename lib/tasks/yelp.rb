require_relative "../parks"

def search(park_name)
  `echo q | googler -C --count 10 #{park_name} national park site:yelp.com`
end

def search_all
  File.open("data/yelp.csv", "w+") do |f|
    Parks.all.map do |park|
      r = search(park['name'])
      urls = r.split("\n").grep(%r[www.yelp.com/])
      map_url = urls.find {|url| url =~ %r[/biz/]}
      puts map_url
      f.write("#{map_url}\n")
    end
  end
end

# `git clone https://github.com/jarun/googler.git`
search_all
