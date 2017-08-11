document.getElementById('navic').onmouseover = function(event) {
  var target = event.target;
  if (target.className == 'men-item') {
    var s = target.getElementsByClassName('submen');
    closeMenu();
    s[0].style.display = 'block';
  }
}

document.onmouseover = function(event) {
  var target = event.target;
  console.log(event.target);
  if (target.className != 'men-item' && target.className != 'submen') {
    closeMenu();
  }
}

function closeMenu() {
  var menu = document.getElementById('navic');
  var subm = document.getElementsByClassName('submen');
  for (var i=0; i < subm.length; i++) {
    subm[i].style.display = "none";
  }
}
