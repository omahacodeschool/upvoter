function Modal(){
  this.modalBG = document.getElementsByClassName("modalBackground")[0];
  this.modal   = document.getElementsByClassName("modal")[0];

  this.hide = function(e) {
    e.preventDefault();
    this.modalBG.style.display = "none";
    this.modal.style.display = "none";
  }

  this.show = function(e) {
    e.preventDefault();
    this.modalBG.style.display = "block";
    this.modal.style.display = "flex";
  }

  this.modalBG.addEventListener('click', hideModal);
}