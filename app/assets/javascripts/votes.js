$(document).ready(function() {
  $(".vote-link").on("click", function(event) {
    // event.preventDefault();
    // var href = $(this).attr("href");
    //
    // var request = $.ajax( {
    //   method: "GET",
    //   url: href
    // });
    //
    // request.done(function(data) {
    //   debugger;
    //   $("#voting_status").append(data.voting_status);
    //
    //   if (data.voting_status === "None") {
    //     $("#up-vote-post").show();
    //     $("#down-vote-post").show();
    //     $("#up-vote-patch").hide();
    //     $("#down-vote-patch").hide();
    //     $("#vote-delete").hide();
    //   } else {
    //     $("#up-vote-post").hide();
    //     $("#down-vote-post").hide();
    //     $("#up-vote-patch").show();
    //     $("#down-vote-patch").show();
    //     $("#vote-delete").show();
    //   }
    // });
  });

  // create up vote
  $("#up-vote-post").on("click", function(event) {
    event.preventDefault();

    var href = $("#up-vote-post").attr("href");

    var request = $.ajax( {
      method: "POST",
      url: href
    });

    request.done(function(data) {
      debugger; 
      // var data = JSON.parse(data);
      // $("#message").append(data.message);
      // $("#voting_status").append(data.voting_status);
      //
      // if (data.voting_status === "None") {
      //   $("#up-vote-post").hide();
      //   $("#down-vote-post").hide();
      //   $("#up-vote-patch").show();
      //   $("#down-vote-patch").show();
      //   $("#vote-delete").show();
      // }
    });
  });

  // create down vote
  $("#down-vote-post").on("click", function(event) {

  });

  // change vote to up vote
  $("#up-vote-patch").on("click", function(event) {

  });

  // change vote to down vote
  $("#down-vote-patch").on("click", function(event) {

  });

  // delete vote
  $("#vote-delete").on("click", function(event) {

  });

});
