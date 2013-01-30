# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#imageS3Uploader").S3Uploader()

  $('#imageS3Uploader').bind "s3_upload_failed", (e, content) ->
  	alert("#{content.filename} failed to upload : #{content.error_thrown}")

  $('#imageS3Uploader').bind 's3_uploads_start', (e) ->
  	$('#new_micropost_form input[name="submittingImage"]').val('yes')