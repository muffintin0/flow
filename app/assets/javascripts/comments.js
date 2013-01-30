$(document).ready(function(){
  $('.new_comment_textarea').bind('hastext', function () {
    $(this).next().removeClass('disabled').attr('disabled', false);
  });
          
  $('.new_comment_textarea').bind('notext', function () {
    $(this).next().addClass('disabled').attr('disabled', true);
  });
});  
