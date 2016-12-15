page.at('articles#index favorites#index', function() {
  var Search = require('search'),
      Menu = require('menu'),
      Favorite = require('favorite');

  new Search();
  new Menu();
  new Favorite();
});
