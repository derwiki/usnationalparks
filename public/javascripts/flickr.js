var flickr = {
  init: function(q) {
    var parks = $('body').data('parks');

    $.each(parks, function(j, park) {
      $.getJSON("https://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?",
        {
          tags: park.title + ' national park',
          tagmode: "any",
          format: "json"
        },
        function(data) {
          $.each(data.items, function(i,item){
            $("<img/>").attr("src", item.media.m).appendTo("#"+park.underscored_title);
            if (i === 2) { return false; }
          }.bind(this));
        }
      );
    });
  }
};
document.addEventListener("DOMContentLoaded", flickr.init);
