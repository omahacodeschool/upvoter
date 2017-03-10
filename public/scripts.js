window.addEventListener('load', function(){
	// All of our modals.
	var newPostModal = new Modal("newPostModal");
	var loginModal = new Modal("loginModal");
	var signUpModal = new Modal("signUpModal");

	// All of our modal submit buttons.
	var newPostSubmitObject = new Modal("newPostSubmit");
	var loginSubmitObject = new Modal("loginSubmit");
	var signUpSubmitObject = new Modal("signUpSubmit");

	var newPostModalSubmit = document.getElementById("newPostSubmit");
	var loginModalSubmit = document.getElementById("loginSubmit");
	var signUpModalSubmit = document.getElementById("signUpSubmit");

// --------------------NOT DONE, START HERE-------------------------------

	// Add click events to modal submit forms.
	newPostModalSubmit.addEventListener('click', newPostSubmitObject.sendNewPost);
	loginModalSubmit.addEventListener('click', loginSubmitObject.sendLogin);
	signUpModalSubmit.addEventListener('click', signUpSubmitObject.sendSignUp);

// --------------------NOT DONE, START HERE-------------------------------

	// Array of all upvote arrows.
	var upvoteArrowArray = document.getElementsByClassName("upvoteButton");
	
	// All of our upvote arrows.
	for (var upvoteButton = 0; upvoteButton < (upvoteArrowArray.length); upvoteButton++){
		var UVButton = document.getElementsByClassName("upvoteButton")[upvoteButton];
		var newButton = new UpvoteButton(UVButton);
		UVButton.addEventListener('click', newButton.upvotePost);
	}

	// Array of all post scores.
	var scoresArray = document.getElementsByClassName("scoreCount");

	// Triggers for click events.
	var newPostButton = document.getElementById("newPostButton");
	var loginLink = document.getElementById("login");
	var signUpLink = document.getElementById("signUp");
	var modalBG = document.getElementById("modalBackground");

	// When the New Post button is clicked, the new post modal becomes visible.
	newPostButton.addEventListener('click', newPostModal.show);

	// When the login link is clicked, the login modal becomes visible.
	loginLink.addEventListener('click', loginModal.show);

	// When the sign up link is clicked, the sign up modal becomes visible.
	signUpLink.addEventListener('click', signUpModal.show);

	// When the modal background is clicked, all modals become invisible.
	modalBG.addEventListener('click', function(){
		newPostModal.hide();
		loginModal.hide();
		signUpModal.hide();
	});
});