function newVoteCreator(clickedVote, nonClickedVoteClass, thirdVoteClass) {
  this.vote = clickedVote;
  this.href = $(clickedVote).attr("href");
  this.reviewElement = $(clickedVote).closest('ul');
  this.nonVoteLink = this.reviewElement.find(nonClickedVoteClass);
  this.reviewId = $(this.reviewElement).attr('id').replace("review_", "");
  this.bookEditLink = $(".edit-book").attr("href");
  this.bookId = this.bookEditLink.replace("/books/", "").replace("/edit", "");
  this.deleteHref = "/api/v1/votes/" + this.bookId + "?review_id=" + this.reviewId;
  this.deleteButtonDiv = $(this.reviewElement).find('.delete-button');
  this.thirdVoteLink = this.reviewElement.find(thirdVoteClass);
}

function changeVotingMessage(message) {
  $("#voting-message").empty();
  $("#voting-message").append(message);
}


$(document).ready(function() {
  $("body").on("click", ".up-vote-post-ajax", function(event) {
    event.preventDefault();

    var newVoteData = new newVoteCreator(this, ".down-vote-post-ajax", '.delete-button');

    var request = $.ajax( {
      method: "POST",
      url: newVoteData.href
    });

    request.done(function(data) {
      changeVotingMessage(data.message);
      $(newVoteData.vote).removeClass("up-vote-post-ajax button vote-button").addClass('up-vote-patch-ajax button vote-button');
      $(newVoteData.vote).attr("data-method", "patch");
      $(newVoteData.nonVoteLink).removeClass("down-vote-post-ajax button vote-button").addClass("down-vote-patch-ajax button vote-button");
      $(newVoteData.nonVoteLink).attr("data-method", "patch");
      if ( data.vote === true ) {
        $(newVoteData.deleteButtonDiv).append("<li><a class='delete-vote-ajax button vote-button' data-remote='true' rel='nofollow' data-method='delete' href=" + newVoteData.deleteHref + ">Delete Vote</a></li>");
      }
    });
  });

  $("body").on("click", ".down-vote-post-ajax", function(event) {
    event.preventDefault();

    var newVoteData = new newVoteCreator(this, ".up-vote-post-ajax", ".delete-button");

    var request = $.ajax( {
      method: "POST",
      url: newVoteData.href
    });

    request.done(function(data) {
      changeVotingMessage(data.message);
      $(newVoteData.nonVoteLink).removeClass("up-vote-post-ajax button vote-button").addClass('up-vote-patch-ajax button vote-button');
      $(newVoteData.nonVoteLink).attr("data-method", "patch");
      $(newVoteData.vote).removeClass("down-vote-post-ajax button vote-button").addClass("down-vote-patch-ajax button vote-button");
      $(newVoteData.vote).attr("data-method", "patch");
      if ( data.vote === true ) {
        $(newVoteData.deleteButtonDiv).append("<li><a class='delete-vote-ajax button vote-button' data-remote='true' rel='nofollow' data-method='delete' href=" + newVoteData.deleteHref + ">Delete Vote</a></li>");
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
      changeVotingMessage(data.message);
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
      changeVotingMessage(data.message);
    });
  });

  $("body").on("click", ".delete-vote-ajax", function(event) {
    event.preventDefault();

    var newVoteData = new newVoteCreator(this, ".up-vote-patch-ajax", ".down-vote-patch-ajax");

    var request = $.ajax( {
      method: "DELETE",
      url: newVoteData.href
    });

    request.done(function(data) {
      changeVotingMessage(data.message); 
      $(newVoteData.vote).remove();
      $(newVoteData.nonVoteLink).removeClass("up-vote-patch-ajax button vote-button").addClass('up-vote-post-ajax button vote-button');
      $(newVoteData.nonVoteLink).attr("data-method", "post");
      $(newVoteData.thirdVoteLink).removeClass("down-vote-patch-ajax button vote-button").addClass("down-vote-post-ajax button vote-button");
      $(newVoteData.thirdVoteLink).attr("data-method", "post");
    });
  });
});
