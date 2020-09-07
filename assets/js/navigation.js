$(document).ready(function(){
  $(".to-about-me, .to-work, .to-contact").click(function() {
    var $section = $($(this).attr("href"));
    $('html, body').animate({scrollTop: $section.offset().top}, 800);
  });
});
