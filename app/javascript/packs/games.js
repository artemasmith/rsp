window.onload = function () {
  // Get the button that opens the modal
  let btns = document.getElementsByClassName("throw_click");

  let modal = document.getElementById("myModal");

  for (let btn of btns) {
    btn.onclick = function () {
      // modal.style.display = "block";
      // console.log("action = " + btn.getAttribute('data-action'));
      // show_your_bet(btn.getAttribute('data-action'));
      make_a_bet(btn);
    }
  }

  let make_a_bet = function(btn) {
    let modal = document.getElementById("myModal");
    modal.style.display = "block";
    
    let action = btn.getAttribute('data-action');
    console.log("action = " + action);
    show_your_bet(action);
    send_bet(action);
  }

  let hide_old_choise = function () {
    let throw_action = document.getElementsByClassName("selected")[0];
    throw_action.classList.add('hidden');
    throw_action.classList.remove('selected');
  }

  let show_your_bet = function(action) {
    console.log('action = ' + action);
    let your_throw = document.querySelectorAll(".hidden[data-action='" + action + "']")[0];
    console.log("your throw" + your_throw);
    your_throw.classList.remove('hidden');
    your_throw.classList.add('selected');
  }

  let send_bet = function(action) {
    const token = document.getElementsByName(
      "csrf-token"
    )[0].content;
    fetch('/games', { method: 'POST',
      headers: { 'Content-Type': 'application/json;charset=utf-8', 'X-CSRF-Token': token },
      body: JSON.stringify({ throw: action})})
      .then(response => response.json())
      .then(result => show_result(JSON.stringify(result, null, 2)))
  }

  let show_result = function(result) {
    document.getElementsByClassName('before-results')[0].classList.add('hidden');
    document.getElementsByClassName('result-modal-content')[0].classList.remove('hidden');

    document.getElementsByClassName('result-text')[0].innerHTML = JSON.parse(result)['result'];
  }

  let hide_result_show_wait_modal = function() {
    document.getElementsByClassName('before-results')[0].classList.remove('hidden');
    document.getElementsByClassName('result-modal-content')[0].classList.add('hidden');
  }

  // Get the <span> element that closes the modal
  let spans = document.getElementsByClassName("close");

  // When the user clicks on <span> (x), close the modal
  for (let span of spans) {
    span.onclick = function () {
      modal.style.display = "none";
      hide_old_choise();
      hide_result_show_wait_modal();
    }
  }

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function (event) {
    if (event.target == modal) {
      modal.style.display = "none";
      hide_old_choise();
      hide_result_show_wait_modal();
    }
  }
}
