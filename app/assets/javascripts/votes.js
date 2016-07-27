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
  $(".up-vote-post-ajax").on("click", function(event) {
    event.preventDefault();

    var href = $(this).attr("href");

    // get review id
    // var reviewIdElement = $(this).closest('tr').attr('id');
    // var reviewId = parseInt(reviewIdElement.replace("review_", ""));

    // get up vote boolean
    // var upVote = true;

    // get down vote boolean
    // var downVote = false;

    var request = $.ajax( {
      method: "POST",
      url: href
      // url: "/api/v1/votes",
      // data: { up_vote: upVote, down_vote: downVote, review_id: reviewId }
    });

    request.done(function(data) {
      debugger; 
      $("#voting-message").append(data.message);

      // $("#voting-status").append(data.voting_status);

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
  $(".down-vote-post-ajax").on("click", function(event) {
    event.preventDefault();

    var href = $(this).attr("href");

    var request = $.ajax( {
      method: "POST",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").append(data.message);
    });
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
