define('tags', [], function() {
  function Tags(tagsListElement) {
    this.tagsList = $(tagsListElement);
    this.tagsUrl = this.tagsList.data('tags-url');

    this._bindEvents();
  };

  var fn = Tags.prototype;

  fn._bindEvents = function() {
    var self = this;

    this.tagsList.select2()
      .on('select2:select', function (evt) {
        window.location = self.tagsUrl + '?tag=' + this.value;
      });
  }

  return Tags;
})
