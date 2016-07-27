$(document).ready(function() {
  // create up vote
  $(".up-vote-post-ajax").on("click", function(event) {
    event.preventDefault();

    var upVoteButton = this;
    var href = $(this).attr("href");

    // get review id
    // var reviewElement = $(this).closest('tr');
    // var reviewIdElement = $(this).closest('tr').attr('id');
    // var reviewId = parseInt(reviewIdElement.replace("review_", ""));

    var request = $.ajax( {
      method: "POST",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").append(data.message);

      //change up vote to patch
      // $(upVoteButton).attr("data-method", "patch")

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
