window.addEventListener('load', function(){

	var modalBG = document.getElementsByClassName("modalBackground")[0];
	var modal = document.getElementsByClassName("modal")[0];
	var newPostButton = document.getElementById("newPostButton");

	for (i = 0; i < 25; i++){
		var upvoteButton = document.getElementsByClassName("upvoteButton")[i];
		//HOW TO CALL THIS FUNCTION ON CLICK???
		upvoteButton.addEventListener('click', function(e){ upvotePost(i) });
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

	function upvotePost(event, i) {
		event.preventDefault();
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