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

  this.sendNewPost = function(e) {
    // Making a new HTTP request.
    var infoRequest = new XMLHttpRequest();
    // This is a post request that sends the post ID and user ID in the query
    // string.
    infoRequest.open('POST', '/newPost');
    // This function executes when the server responds that it received the
    // request.
    // Example: If the user clicks "upvote" on a post, when the server responds
    // that it received the request, only then will it update the like counter.
    infoRequest.onload = function(){
    };
    // This line sends the request.
    infoRequest.send();
  }

  this.sendLogin = function(e) {
    // Making a new HTTP request.
    var infoRequest = new XMLHttpRequest();
    // This is a post request that sends the post ID and user ID in the query
    // string.
    infoRequest.open('POST', '/login?');
    // This function executes when the server responds that it received the
    // request.
    // Example: If the user clicks "upvote" on a post, when the server responds
    // that it received the request, only then will it update the like counter.
    infoRequest.onload = function(){
    };
    // This line sends the request.
    infoRequest.send();
  }

  this.sendSignUp = function(e) {
    // Making a new HTTP request.
    var infoRequest = new XMLHttpRequest();
    // This is a post request that sends the post ID and user ID in the query
    // string.
    infoRequest.open('POST', '/newUser?');
    // This function executes when the server responds that it received the
    // request.
    // Example: If the user clicks "upvote" on a post, when the server responds
    // that it received the request, only then will it update the like counter.
    infoRequest.onload = function(){
    };
    // This line sends the request.
    infoRequest.send();
  }
}