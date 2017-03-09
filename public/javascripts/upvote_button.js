function UpvoteButton(UVButton){

  // This function finds the parent element and adds a class that will change 
  // the color of the arrow to red.
  this.upvotePost = function(e) {
    e.preventDefault();
    
    var thisButtonForm = e.target.parentNode;
    var formClasses = thisButtonForm.className;

    var scoreCount = e.target.parentNode.nextSibling.nextSibling.innerHTML;

    // If the form only has "upvoteform" class, adds the "articleLiked" class.
    if (formClasses === "upvoteform"){
      e.preventDefault();
      thisButtonForm.className += " articleLiked";
      addScore(scoreCount, e);
    }

    // Otherwise resets the class to just "upvoteform".
    else {
      e.preventDefault();
      thisButtonForm.className = "upvoteform";
      subScore(scoreCount, e);
    }
  }

  // Adds one to the like score count for the liked post.
  function addScore(score, e){
    var intScore = parseInt(score);
    intScore += 1;
    var newScore = intScore.toString();
    
    e.target.parentNode.nextSibling.nextSibling.innerHTML = newScore;
    updateDatabase(e);
  }

  // Subtracts one from the like score count for the unliked post.
  function subScore(score, e){
    var intScore = parseInt(score);
    intScore -= 1;
    var newScore = intScore.toString();
    
    e.target.parentNode.nextSibling.nextSibling.innerHTML = newScore;
    updateDatabase(e);
  }

  function updateDatabase(e){
    // Making a new HTTP request.
    var upvoteRequest = new XMLHttpRequest();
    // Setting the address that we will be posting to.
    var action = e.target.parentNode.action;
    // This is a post request that sends the post ID and user ID in the query
    // string.
    upvoteRequest.open('POST', action);
    // This function executes when the server responds that it received the
    // request.
    // Example: If the user clicks "upvote" on a post, when the server responds
    // that it received the request, only then will it update the like counter.
    upvoteRequest.onload = function(){
      alert("I got your request.");
    };
    // This line sends the request.
    upvoteRequest.send();
  }
};