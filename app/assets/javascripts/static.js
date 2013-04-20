$(document).ready(function() {
  $("#sign_in_modal_form").validate({
      onfocusout: function(element) { $(element).valid(); } ,

      rules: {
          "user[email]":{
              required: true,
          },
          "user[password]":{
              required: true,
          },
      },
      messages: {
          "user[email]":{
              required: "The emaill address is required",
          },
          "user[password]":{
              required: "The password is required",
          },
      },
      errorElement: "div",
  });


  $("#sign_up_modal_form").validate({
      onfocusout: function(element) { $(element).valid(); } ,

      rules: {
          "user[username]":{
              required: true,
              remote: "/users/check_username"
          },
          "user[email]":{
              required: true,
              email: true,
              remote: '/users/check_email'
          },
          "user[password]":{
              required: true,
              minlength: 6
          },
          "user[password_confirmation]":{
              required: true,
              minlength: 6,
              equalTo: "#password" //the password input id is manually set
          }
      },
      messages: {
          "user[username]":{
              required: "The user name is required",
              remote: "The username has already been taken"
          },
          "user[email]":{
              required: "The email address is required",
              email: "A valid email address is required",
              remote: "The email address has already been taken"
          },
          "user[password]":{
              required: "The password is required",
              minlength: "Min Length is 6 characters"
          },
          "user[password_confirmation]":{
              required: "The repeate password is required",
              minlength: "Min Length is 6 characters",
              equalTo: "Passwords Doesn't Match"
          }
      },
      errorElement: "div",
  });

  // for signed in user homepage
  $('#more_post_row form :submit').click(function(){
    $(this).val('Loading micropost feeds');
  });

});