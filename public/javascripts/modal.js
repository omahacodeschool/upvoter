// Modal object class. Requires the modal ID to target the specific modal.
function Modal(id){

	// Modal background and the particular modal being targeted.
	var modalBG = document.getElementById("modalBackground");
	var modal  = document.getElementById(id);

	// Hides the visible modal background and modal window.
	this.hide = function() {
		modalBG.style.display = "none";
		modal.style.display = "none";
	}

	// Makes the modal window and modal background visible.
	this.show = function(e) {
		e.preventDefault();
		modalBG.style.display = "block";
		modal.style.display = "flex";
	}
}