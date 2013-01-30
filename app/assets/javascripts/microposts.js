$(document).ready(function(){

	$('#new_micropost_form').find('textarea').bind('hastext', function () {
		if ( $('#new_micropost_form input[name="submittingImage"]').val() == 'no' ){
	  	$('#new_micropost_form').find(':submit').removeClass('disabled').attr('disabled', false);
	  }
	});
	        
	$('#new_micropost_form').find('textarea').bind('notext', function () {
	  $('#new_micropost_form').find(':submit').addClass('disabled').attr('disabled', true);
	});

  $("#new_post_add_more_image_button").click(function(){
    $(".new_post_add_more_image_fields").toggle();
  })

  $(".micropost_comment_revealer").click(function(event){
    event.preventDefault();
    $(this).parent().parent().next(".micropost_comments").toggle();
  });
});  