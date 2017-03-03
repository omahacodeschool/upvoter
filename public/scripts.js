window.addEventListener('load', function(){
	var modalBG = document.getElementsByClassName("modalBackground")[0];
	var modal = document.getElementsByClassName("modal")[0];
	var newPostButton = document.getElementById("newPostButton");

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
});