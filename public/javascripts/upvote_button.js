function UpvoteButton(UVButton){

  UVButton.addEventListener('click', function(event){ upvotePost(event); });

  function upvotePost(event) {
    event.preventDefault();
    
    var thisButtonForm = event.target.parentNode;
    var formClasses = thisButtonForm.className;

    if (formClasses === "upvoteform"){
      thisButtonForm.className += " articleLiked";
    }
    else {
      thisButtonForm.className = "upvoteform";
    }
    
  }
};