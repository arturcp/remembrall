page.at('articles#index favorites#index tags#index', function() {
  var Search = require('search'),
      Menu = require('menu'),
      Favorite = require('favorite'),
      Tags = require('tags');

  new Search();
  new Menu();
  new Favorite();
  new Tags('#tags-list');
});
