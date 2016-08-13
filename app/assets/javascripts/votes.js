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
  $(upVote).attr("data-method", dataMethod);
  $(downVote).removeClass("down-vote-" + currentDataMethod + "-ajax button vote-button").addClass("down-vote-" + dataMethod + "-ajax button vote-button");
  $(downVote).attr("data-method", dataMethod);
}

function addDeleteButton(deleteButtonDiv, deleteHref) {
  var string = "<li><a class='delete-vote-ajax button vote-button'"
  string +=  "data-remote='true' rel='nofollow' data-method='delete' href="
  string += deleteHref
  string += ">Delete Vote</a></li>"
  $(deleteButtonDiv).append(string);
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
      // need to get the vote object and pass in the vote id to properly recreate the patch url...
      // remember this also has to be done on the server side in the _show_reviews.html.erb
      addRemoveClass(newVoteData.vote, newVoteData.nonVoteLink, "patch");
      if ( data.vote === true ) {
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
      // need to get the vote object and pass in the vote id to properly recreate the patch url...
      // remember this also has to be done on the server side in the _show_reviews.html.erb
      addRemoveClass(newVoteData.nonVoteLink, newVoteData.vote, "patch");
      if ( data.vote === true ) {
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
    });
  });
});
