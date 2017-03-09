window.addEventListener('load', function(){
	// All of our modals.
	var newPostModal = new Modal("newPostModal");
	var loginModal = new Modal("loginModal");
	var signUpModal = new Modal("signUpModal");
	
	// All of our upvote arrows.
	for (upvoteButton in document.getElementsByClassName("upvoteButton")){
		var UVButton = document.getElementsByClassName("upvoteButton")[upvoteButton];
		new UpvoteButton(UVButton);
	}

	// Triggers for click events.
	var newPostButton = document.getElementById("newPostButton");
	var loginLink = document.getElementById("login");
	var signUpLink = document.getElementById("signUp");
	var modalBG = document.getElementById("modalBackground");

	// When the New Post button is clicked, the new post modal becomes visible.
	newPostButton.addEventListener('click', newPostModal.show);

	// When the login link is clicked, the login modal becomes visible.
	loginLink.addEventListener('click', loginModal.show);

	signUpLink.addEventListener('click', signUpModal.show);

	// When the modal background is clicked, all modals become invisible.
	modalBG.addEventListener('click', function(){
		newPostModal.hide();
		loginModal.hide();
		signUpModal.hide();
	});
});