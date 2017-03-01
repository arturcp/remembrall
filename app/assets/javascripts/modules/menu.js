define('menu', [], function() {
  function Menu() {
    this.button = $("[data-activates]");

    this._bindEvents();
  };

  var fn = Menu.prototype;

  fn._bindEvents = function() {
    this.button.sideNav();
  };

  return Menu;
})
