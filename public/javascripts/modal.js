function Modal(id){

  var modalBG = document.getElementById("modalBackground");
  var modal  = document.getElementById(id);

  this.hide = function(e) {
    e.preventDefault();
    modalBG.style.display = "none";
    modal.style.display = "none";
  }

  this.show = function(e) {
    e.preventDefault();
    modalBG.style.display = "block";
    modal.style.display = "flex";
  }
}