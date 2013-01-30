// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require bootstrap
//= require jquery.textchange.min
//= require s3_direct_upload
//= require static
//= require users
//= require microposts
//= require comments



var timeoutObj; //control the leaving of user_icon, remove popover

$(document).ready(function(){
	jQuery("a.internet_images").colorbox({maxWidth:"600px"});

	//the popover on the user icon
	//$('.user_popover').popover({html:true, trigger:'hover'});

	$('.user_popover').popover({
    offset: 10,
    trigger: 'manual',
    animate: true,
    html: true,
    placement: 'right',
    template: '<div class="popover" onmouseover="clearTimeout(timeoutObj);$(this).mouseleave(function() {$(this).hide(); });"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>'

  }).click(function(e) {
      e.preventDefault() ;
  }).mouseenter(function(e) {
      $(this).popover('show');
  }).mouseleave(function(e) {
    var ref = $(this);
    timeoutObj = setTimeout(function(){
        ref.popover('hide');
    }, 50)});

  $('#username_searchbox').typeahead({

    source: function (query, process) {
        return $.get(
            '/users/search',
            { query: query },
            function (data) {
                return process(data);
            });
    },

    updater: function(item){
      window.location = '/users/'+item;
      return item;
    }
  });

  //check user online every 30 s
  var alive = setInterval(function(){
    $.post('/users/update_activity');
    //alert('activity updated');
  },30000);  

});