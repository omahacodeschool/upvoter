window.addEventListener('load', function(){

	var modalBG = document.getElementsByClassName("modalBackground")[0];
	var modal = document.getElementsByClassName("modal")[0];
	var newPostButton = document.getElementById("newPostButton");

	for (upvoteButton in document.getElementsByClassName("upvoteButton")){
		upvoteButton.addEventListener('click', upvotePost);
	}
	
	newPostButton.addEventListener('click', showModal);
	modalBG.addEventListener('click', hideModal);

	function showModal(e) {
		e.preventDefault();
		modalBG.style.display = "block";
		modal.style.display = "flex";
	}

	function hideModal(e) {
		e.preventDefault();
		modalBG.style.display = "none";
		modal.style.display = "none";
	}

	function upvotePost(event) {
		event.preventDefault();
		// TODO Using your button, which is event.target, use DOM traversal to get
		// to its parent form.
		var formClass = document.getElementsByClassName("upvoteform")[i];
		var testClasses = formClass.className;
		
		if (testClasses === "upvoteform"){
			formClass.className += " articleLiked";
			event.preventDefault();
		}
		else {
			formClass.className = "upvoteform";
			event.preventDefault();
		}
		
	}
});