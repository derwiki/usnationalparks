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
          var description = flickr.cleanDescription(item.description);

          var $img = $("<img/>")
            .attr("src", item.media.m)
            .attr("title", item.title)
            .attr("alt", item.title);
          var $desc = $("<div/>")
            .html(description);
          var $link = $("<a/>")
            .attr("href", item.link)
            .html($img);

          $link.appendTo("#"+park.underscored_title);
          $desc.appendTo("#"+park.underscored_title);
          if (i === 2) { return false; }
        }.bind(this));
      }
    );
  },

  cleanDescription: function(desc) {
    var matches = desc.match(/ ?posted a photo:/);
    matches && matches.forEach(function(junk) {
      desc = desc.replace(junk, '');
    });
    return desc;
  }
};
document.addEventListener("DOMContentLoaded", flickr.init);
