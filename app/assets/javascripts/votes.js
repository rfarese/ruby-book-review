$(document).ready(function() {
  $(".up-vote-post-ajax").on("click", function(event) {
    event.preventDefault();

    var upVoteLink = this;
    var href = $(this).attr("href");
    var reviewElement = $(this).closest('tr');
    var downVoteLink = reviewElement.find(".down-vote-post-ajax");

    var request = $.ajax( {
      method: "POST",
      url: href
    });

    request.done(function(data) {
      debugger; 
      $("#voting-message").append(data.message);
      $(upVoteLink).removeClass("up-vote-post-ajax").addClass('up-vote-patch-ajax');
      $(upVoteLink).attr("data-method", "patch");
      $(downVoteLink).removeClass("down-vote-post-ajax").addClass("down-vote-patch-ajax");
      $(downVoteLink).attr("data-method", "patch");
    });
  });

  $(".down-vote-post-ajax").on("click", function(event) {
    event.preventDefault();

    var href = $(this).attr("href");
    var downVoteLink = this;
    var reviewElement = $(this).closest('tr');
    var upVoteLink = reviewElement.find(".up-vote-post-ajax");

    var request = $.ajax( {
      method: "POST",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").append(data.message);
      $(upVoteLink).removeClass("up-vote-post-ajax").addClass('up-vote-patch-ajax');
      $(upVoteLink).attr("data-method", "patch");
      $(downVoteLink).removeClass("down-vote-post-ajax").addClass("down-vote-patch-ajax");
      $(downVoteLink).attr("data-method", "patch");
    });
  });

  // change vote to up vote
  $("#up-vote-patch-ajax").on("click", function(event) {
    event.preventDefault();

    var href = $(this).attr("href");

    var request = $.ajax( {
      method: "PATCH",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").append(data.message);
    });
  });

  // change vote to down vote
  $("#down-vote-patch-ajax").on("click", function(event) {
    event.preventDefault();

    var href = $(this).attr("href");

    var request = $.ajax( {
      method: "PATCH",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").append(data.message);
    });
  });

  // delete vote
  $("#vote-delete").on("click", function(event) {

  });

});
