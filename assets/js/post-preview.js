$(document).ready(function(){
  
  $(".preview-post-form").on("submit", function(e){
    e.preventDefault(); 
    var $postBody = $("form.post-form .body").val(); 
    var xcsrfToken = $(".preview-post-form input[name='_csrf_token']").val()

    $.post({
      url: "/post-preview", 
      data: {
        "post_body": $postBody
      },
      beforeSend: function(xhr)
        {
          xhr.setRequestHeader('x-csrf-token', xcsrfToken );
        },
    }).done(function(data){
      $(".preview-post-body").html(data.data.post_body);
    });

  });
});
