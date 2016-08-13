function newVoteCreator(clickedVote, nonClickedVoteClass, thirdVoteClass) {
  this.vote = clickedVote;
  this.href = $(clickedVote).attr("href");
  this.reviewElement = $(clickedVote).closest('ul');
  this.nonVoteLink = this.reviewElement.find(nonClickedVoteClass);
  this.reviewId = $(this.reviewElement).attr('id').replace("review_", "");
  this.currentPath = window.location.pathname
  this.bookId = this.currentPath.replace("/books/", "");
  this.deleteHref = "/api/v1/votes/" + this.bookId + "?review_id=" + this.reviewId;
  this.deleteButtonDiv = $(this.reviewElement).find('.delete-button');
  this.thirdVoteLink = this.reviewElement.find(thirdVoteClass);
}

function changeVotingMessage(message) {
  $("#voting-message").empty();
  $("#voting-message").append(message);
}

function getCurrentDataMethod(dataMethod) {
  var currentDataMethod = "";

  if (dataMethod === 'post') {
    currentDataMethod = 'patch';
  } else {
    currentDataMethod = 'post';
  }
  return currentDataMethod
}

function addRemoveClass(upVote, downVote, dataMethod) {
  var currentDataMethod = getCurrentDataMethod(dataMethod);
  $(upVote).removeClass("up-vote-" + currentDataMethod + "-ajax button vote-button").addClass("up-vote-" + dataMethod + "-ajax button vote-button");
  $(downVote).removeClass("down-vote-" + currentDataMethod + "-ajax button vote-button").addClass("down-vote-" + dataMethod + "-ajax button vote-button");
}

function addDeleteButton(deleteButtonDiv, deleteHref) {
  var string = "<li><a class='delete-vote-ajax button vote-button' href="
  string += deleteHref
  string += ">Delete Vote</a></li>"
  $(deleteButtonDiv).append(string);
}

function createHrefs(upVote, downVote, voteId, reviewId) {
  var upVoteHref = "/api/v1/votes" + voteId + "?down_vote=false&amp;review_id=" + reviewId + "&amp;up_vote=true"
  var downVoteHref = "/api/v1/votes" + voteId + "?down_vote=true&amp;review_id=" + reviewId + "&amp;up_vote=false"
  $(upVote).attr("href", upVoteHref);
  $(downVote).attr("href", downVoteHref);
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

      if ( data.created === true ) {
        var voteId = "/" + data.vote.id
        createHrefs(newVoteData.vote, newVoteData.nonVoteLink, voteId, newVoteData.reviewId);
        addRemoveClass(newVoteData.vote, newVoteData.nonVoteLink, "patch");
        addDeleteButton(newVoteData.deleteButtonDiv, newVoteData.deleteHref);
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

      if ( data.created === true ) {
        var voteId = "/" + data.vote.id
        createHrefs(newVoteData.nonVoteLink, newVoteData.vote, voteId, newVoteData.reveiewId);
        addRemoveClass(newVoteData.nonVoteLink, newVoteData.vote, "patch");
        addDeleteButton(newVoteData.deleteButtonDiv, newVoteData.deleteHref);
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
      addRemoveClass(newVoteData.nonVoteLink, newVoteData.thirdVoteLink, "post");
      createHrefs(newVoteData.nonVoteLink, newVoteData.thirdVoteLink, "", newVoteData.reviewId);
    });
  });
});
