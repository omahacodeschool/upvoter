function UpvoteButton(UVButton){

  this.upvotePost = function(e) {
    e.preventDefault();
    
    var thisButtonForm = e.target.parentNode;
    var formClasses = thisButtonForm.className;

    var scoreCount = e.target.parentNode.nextSibling.nextSibling.innerHTML;

    if (formClasses === "upvoteform"){
      e.preventDefault();
      thisButtonForm.className += " articleLiked";
      addScore(scoreCount, e);
    }

    else {
      e.preventDefault();
      thisButtonForm.className = "upvoteform";
      subScore(scoreCount, e);
    }
    
  }

  function addScore(score, e){
    var intScore = parseInt(score);
    intScore += 1;
    var newScore = intScore.toString();
    
    e.target.parentNode.nextSibling.nextSibling.innerHTML = newScore;
    // updateDatabase(newScore);
  }

  function subScore(score, e){
    var intScore = parseInt(score);
    intScore -= 1;
    var newScore = intScore.toString();
    
    e.target.parentNode.nextSibling.nextSibling.innerHTML = newScore;
    // updateDatabase(newScore);
  }

  // function updateDatabase()
};