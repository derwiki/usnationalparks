require_relative "../parks"

def search(park_name)
  `echo q | googler/googler -C --count 10 #{park_name} national park site:instagram.com`
end

def search_all
  File.open("data/instagram.csv", "w+") do |f|
    Parks.all.map do |park|
      r = search(park['name'])
      urls = r.split("\n").grep(%r[https://www.instagram.com/])
      map_url = urls.find {|url| url =~ /nps/} ||
                urls.find {|url| url =~ /explore/}
      puts map_url
      f.write("#{map_url}\n")
    end
  end
end

`git clone https://github.com/jarun/googler.git`
search_all
