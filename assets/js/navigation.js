$(document).ready(function(){
  $(".hamburger").on("click", function(e){
    console.log("justclicked!");
    $("nav").toggleClass("display-mobile-nav");
  });
});
