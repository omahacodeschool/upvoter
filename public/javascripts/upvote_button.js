function UpvoteButton(UVButton){

  UVButton.addEventListener('click', function(event){ upvotePost(event); });

  function upvotePost(event) {
    event.preventDefault();
    
    var thisButtonForm = event.target.parentNode;
    var formClasses = thisButtonForm.className;

    if (formClasses === "upvoteform"){
      event.preventDefault();
      thisButtonForm.className += " articleLiked";
    }
    else {
      event.preventDefault();
      thisButtonForm.className = "upvoteform";
    }
    
  }
};