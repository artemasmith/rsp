window.onload = function () {
  // Get the button that opens the modal
  let btns = document.getElementsByClassName("throw_click");

  let modal = document.getElementById("myModal");

  for (let btn of btns) {
    btn.onclick = function () {
      make_a_bet(btn);
    }
  }

  let make_a_bet = function(btn) {
    let modal = document.getElementById("myModal");
    modal.style.display = "block";
    
    let action = btn.getAttribute('data-action');

    show_your_bet(action);
    send_bet(action);
  }

  let hide_old_choise = function () {
    let throw_action = document.getElementsByClassName("selected")[0];
    throw_action.classList.add('hidden');
    throw_action.classList.remove('selected');
  }

  let show_your_bet = function(action) {
    let your_throw = document.querySelectorAll(".hidden[data-action='" + action + "']")[0];
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
    // debugger;
    document.getElementsByClassName('before-results')[0].classList.add('hidden');
    document.getElementsByClassName('result-modal-content')[0].classList.remove('hidden');

    const parsed_result = JSON.parse(result);
    const service_throw = parsed_result['service_throw'];
    document.getElementsByClassName('result-text')[0].innerHTML = "You " + parsed_result['result'];
    const your_throw = document.querySelectorAll(".result.hidden[data-action='" + service_throw + "']")[0];

    your_throw.classList.remove('hidden');
    const text = document.querySelectorAll(".second[data-text='Curb " + parsed_result['service_throw'] + "']")[0];

    update_game_status_text(text, parsed_result['result']);
  }

  let update_game_status_text = function (text_field, result) {
    text_field.innerHTML = text_field.innerHTML.replaceAll('won', '');
    text_field.innerHTML = text_field.innerHTML.replaceAll('lost', '');
    text_field.innerHTML = text_field.innerHTML.replaceAll('tie', '');

    if (result === 'win') {
      text_field.innerHTML += "lost";
    } else if (result === 'tie') {
      text_field.innerHTML += "tie";
    } else if (result === 'loose') {
      text_field.innerHTML += 'won';
    }
  }

  let hide_result_show_wait_modal = function() {
    document.getElementsByClassName('before-results')[0].classList.remove('hidden');
    document.getElementsByClassName('result-modal-content')[0].classList.add('hidden');
    const throws = document.getElementsByClassName("result");
    for (let your_throw of throws) {
      your_throw.classList.add('hidden');
    }
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
