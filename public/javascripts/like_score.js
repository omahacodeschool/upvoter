// function LikeScore(score){

// 	this.changeScore = function(){
// 		var thisButtonForm = e.target.parentNode;
// 		var formClasses = thisButtonForm.className;

// 		if (formClasses === "upvoteform"){
// 			e.preventDefault();
// 			addScore(scoreCount, e);
// 		}

// 		else {
// 			e.preventDefault();
// 			subScore(scoreCount, e);
// 		}
// 	}
	

// 	function addScore(score, e){
// 	  var intScore = parseInt(score);
// 	  intScore += 1;
// 	  var newScore = intScore.toString();
	  
// 	  e.target.parentNode.nextSibling.nextSibling.innerHTML = newScore;
// 	  // updateDatabase(newScore);
// 	}

// 	function subScore(score, e){
// 	  var intScore = parseInt(score);
// 	  intScore -= 1;
// 	  var newScore = intScore.toString();
	  
// 	  e.target.parentNode.nextSibling.nextSibling.innerHTML = newScore;
// 	  // updateDatabase(newScore);
// 	}
// }