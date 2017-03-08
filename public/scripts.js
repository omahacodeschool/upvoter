window.addEventListener('load', function(){
	var newPostModal = new Modal("newPostModal");
	var loginModal = new Modal("loginModal");
	

	// for (upvoteButton in document.getElementsByClassName("upvoteButton")){
	// 	new UpvoteButton(upvoteButton);
	// }

	var newPostButton = document.getElementById("newPostButton");
	var loginLink = document.getElementById("login");
	var modalBG = document.getElementById("modalBackground");

	newPostButton.addEventListener('click', newPostModal.show);
	loginLink.addEventListener('click', loginModal.show);
	modalBG.addEventListener('click', newPostModal.hide)
});