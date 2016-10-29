define('search', [], function() {
  function Search() {
    this.input = $('#search');

    this._bindEvents();
  };

  var fn = Search.prototype;

  fn._bindEvents = function() {
    this.input.focus();
    this.input.on('keyup', $.proxy(this._searchWord, this));

    $(window).on('focus', $.proxy(this._selectTextOnSearchInput, this));
  };

  fn._searchWord = function(e) {
    var enterKeyCode = 13;
    if (e.keyCode === enterKeyCode) {
      $('body').removeClass('loaded');

      $.getJSON(this.input.data('search-url'), function(data) {
        $('body').addClass('loaded');
      });
    }
  };

  fn._selectTextOnSearchInput = function() {
    this.input.focus().select();
  };

  return Search;
})
