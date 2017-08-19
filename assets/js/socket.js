import {Socket} from "phoenix"
let socket = new Socket("/socket", {params: {token: window.userToken}})
socket.connect()

let channel = socket.channel("pos", {})
channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp)
    $("#intro-text").text(resp.message)
  })
  .receive("error", resp => { console.log("Unable to join", resp) })


channel.on('message:new', payload => {
  renderMessage(payload, "MangoRobot")
})

let chatMessages = $("#pos-chat-room")

let renderMessage = (payload, user) => {
  let template = document.createElement("li")
  template.innerHTML = `<div class="chat-body">
      <div class="header">
        <strong class="primary-font">${user}</strong>
      </div>
      <p>${payload.message}</p>
    </div>`
  chatMessages.append(template);
}

let input = $('.chat-input > input')
input.on('keypress', event => {
  if(event.keyCode == 13) {
    let message = input.val();
    let command_regex = /^\/(\w+)\s*([\w\s]*)/g
    let parts = command_regex.exec(message)

    renderMessage({message: message}, "You")
    input.val("")

    channel.push(parts[1], { message: parts[2] }).receive(
       "ok", (reply) => renderMessage(reply, "Mango")
     ).receive(
       "error", (reply) => console.log("got reply", reply)
      )
  }
});

export default socket
