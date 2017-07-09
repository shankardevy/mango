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
  
export default socket
