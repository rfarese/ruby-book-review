$(document).ready(function() {
  $("body").on("click", ".up-vote-post-ajax", function(event) {
    event.preventDefault();

    var upVoteLink = this;
    var href = $(this).attr("href");
    var reviewElement = $(this).closest('ul');
    var downVoteLink = reviewElement.find(".down-vote-post-ajax");
    var reviewId = $(reviewElement).attr('id').replace("review_", "");
    var bookEditLink = $(".edit-book").attr("href");
    var bookId = bookEditLink.replace("/books/", "").replace("/edit", "");
    var deleteHref = "/api/v1/votes/" + bookId + "?review_id=" + reviewId
    var deleteButtonDiv = $(reviewElement).find('.delete-button');

    var request = $.ajax( {
      method: "POST",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").empty();
      $("#voting-message").append(data.message);
      $(upVoteLink).removeClass("up-vote-post-ajax button vote-button").addClass('up-vote-patch-ajax button vote-button');
      $(upVoteLink).attr("data-method", "patch");
      $(downVoteLink).removeClass("down-vote-post-ajax button vote-button").addClass("down-vote-patch-ajax button vote-button");
      $(downVoteLink).attr("data-method", "patch");
      if ( data.vote === true ) {
        $(deleteButtonDiv).append("<li><a class='delete-vote-ajax button vote-button' data-remote='true' rel='nofollow' data-method='delete' href=" + deleteHref + ">Delete Vote</a></li>");
      }
    });
  });

  $("body").on("click", ".down-vote-post-ajax", function(event) {
    event.preventDefault();

    var href = $(this).attr("href");
    var downVoteLink = this;
    var reviewElement = $(this).closest('ul');
    var upVoteLink = reviewElement.find(".up-vote-post-ajax");
    var reviewId = $(reviewElement).attr('id').replace("review_", "");
    var bookEditLink = $(".edit-book").attr("href");
    var bookId = bookEditLink.replace("/books/", "").replace("/edit", "");
    var deleteHref = "/api/v1/votes/" + bookId + "?review_id=" + reviewId
    var deleteButtonDiv = $(reviewElement).find('.delete-button');

    var request = $.ajax( {
      method: "POST",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").empty();
      $("#voting-message").append(data.message);
      $(upVoteLink).removeClass("up-vote-post-ajax button vote-button").addClass('up-vote-patch-ajax button vote-button');
      $(upVoteLink).attr("data-method", "patch");
      $(downVoteLink).removeClass("down-vote-post-ajax button vote-button").addClass("down-vote-patch-ajax button vote-button");
      $(downVoteLink).attr("data-method", "patch");
      if ( data.vote === true ) {
        $(deleteButtonDiv).append("<li><a class='delete-vote-ajax button vote-button' data-remote='true' rel='nofollow' data-method='delete' href=" + deleteHref + ">Delete Vote</a></li>");
      }
    });
  });

  $("body").on("click", ".up-vote-patch-ajax", function(event) {
    event.preventDefault();

    var href = $(this).attr("href");

    var request = $.ajax( {
      method: "PATCH",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").empty();
      $("#voting-message").append(data.message);
    });
  });

  $("body").on("click", ".down-vote-patch-ajax", function(event) {
    event.preventDefault();

    var href = $(this).attr("href");

    var request = $.ajax( {
      method: "PATCH",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").empty();
      $("#voting-message").append(data.message);
    });
  });

  $("body").on("click", ".delete-vote-ajax", function(event) {
    event.preventDefault();

    var reviewElement = $(this).closest('ul');
    var deleteLink = this;
    var href = $(this).attr("href");
    var downVoteLink = reviewElement.find(".down-vote-patch-ajax");
    var upVoteLink = reviewElement.find(".up-vote-patch-ajax");

    var request = $.ajax( {
      method: "DELETE",
      url: href
    });

    request.done(function(data) {
      $("#voting-message").empty();
      $("#voting-message").append(data.message);
      $(deleteLink).remove();
      $(upVoteLink).removeClass("up-vote-patch-ajax button vote-button").addClass('up-vote-post-ajax button vote-button');
      $(upVoteLink).attr("data-method", "post");
      $(downVoteLink).removeClass("down-vote-patch-ajax button vote-button").addClass("down-vote-post-ajax button vote-button");
      $(downVoteLink).attr("data-method", "post");
    });
  });
});
