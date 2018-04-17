$(document).ready(function(){
  $(".hamburger").on("click", function(e){
    $("nav").toggleClass("display-mobile-nav");
  });

  $(".to-about-me, .to-work, .to-contact").click(function() {
    var $section = $($(this).attr("href"));
    $('html, body').animate({scrollTop: $section.offset().top}, 'slow');
  });
});
