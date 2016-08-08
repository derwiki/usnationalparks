var flickr = {
  init: function(q) {
    var parks = $('body').data('parks');

    $.each(parks, function(j, park) {
      flickr.for_park(park);
    });
  },

  for_park: function(park) {
    $.getJSON("https://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?",
      {
        tags: park.title + ' national park',
        tagmode: "any",
        format: "json"
      },
      function(data) {
        $.each(data.items, function(i, item){

          var url = item.media.m.replace("_m.jpg", "_z.jpg");

          var $img = $("<img/>")
            .attr("src", url)
            .attr("title", item.title)
            .attr("alt", item.title);
          var $link = $("<a/>")
            .attr("href", item.link)
            .html($img);

          $link.appendTo("#"+park.underscored_title);

          if (i === 3) { return false; }
        }.bind(this));
      }
    );
  },
};
document.addEventListener("DOMContentLoaded", flickr.init);
