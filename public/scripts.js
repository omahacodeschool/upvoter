window.addEventListener('load', function(){
	var mainModal = new Modal();

	for (upvoteButton in document.getElementsByClassName("upvoteButton")){
		new UpvoteButton(upvoteButton);
	}
});