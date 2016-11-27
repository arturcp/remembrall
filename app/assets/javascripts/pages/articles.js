page.at('articles#index', function() {
  var Search = require('search'),
      Menu = require('menu');

  new Search();
  new Menu();
});
