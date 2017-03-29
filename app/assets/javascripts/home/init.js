$(document).ready(function(){
  $('.button-collapse').sideNav();
  $('.parallax').parallax();

  $('.materialboxed').materialbox();
  $('.button-collapse').sideNav();

  $('.head-link').click(function(e) {
    e.preventDefault();

    var goto = $(this).attr('href');

    $('html, body').animate({
      scrollTop: $(goto).offset().top
    }, 800);
  });
});
