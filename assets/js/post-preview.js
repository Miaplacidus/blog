$(document).ready(function(){

  $(".preview-post-button").on("click", function(){
    var $postBody = $("form .body").val(); 

    $.ajax({
      url: "/post-preview", 
      data: {"post_body": $postBody}
    }).done(function(data){
      console.log(data.data.post_body);
      $(".preview-post-body").html(data.data.post_body);
    });
  });
});
