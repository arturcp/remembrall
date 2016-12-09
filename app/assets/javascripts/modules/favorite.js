define('favorite', [], function() {
  function Favorite() {
    this.favoriteIcons = $('[data-favorite-icon]');
    this._bindEvents();
  };

  var fn = Favorite.prototype;

  fn._bindEvents = function() {
    this.favoriteIcons.on('click', $.proxy(this._changeFavoriteStatus, this));
  };

  fn._changeFavoriteStatus = function(event) {
    var element = $(event.currentTarget),
        url = element.parents("[data-favorite-url]").first().data("favorite-url"),
        self = this;

    $.ajax({
      url: url,
      method: "POST",
      data: {
        article_id: element.parents("[data-article-id]").first().data("article-id")
      }
    }).done(function() {
      self._changeIcon(element);
    });
  };

  fn._changeIcon = function(icon) {
    var favoritedClass = "favorited";

    if (icon.hasClass(favoritedClass)) {
      icon.removeClass("fa-heart").addClass("fa-heart-o");
    } else {
      icon.removeClass("fa-heart-o").addClass("fa-heart");
    }

    icon.toggleClass(favoritedClass);
  };

  return Favorite;
});
