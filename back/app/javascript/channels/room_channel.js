//import consumer from "./consumer"

//document.addEventListener("turbolinks:load", () => {
  //const room_id = document.getElementById("room_id")
  //if (room_id === null) {
   // return
  //}
  //const user_id = document.getElementById("current_user")
  //if (user_id === null) {
    //return
  //}
  //if (!isSubscribed(channel, room_id, user_id)) {
  //consumer.subscriptions.create(
   // { channel: "RoomChannel", room_id: room_id, user_id: user_id },
    //{
      //connected() {
        // Called when the subscription is ready for use on the server
      //},

      //disconnected() {
        // Called when the subscription has been terminated by the server
      //},

      //received(data) {
        // Called when there's incoming data on the websocket for this channel
      //}
    //}
  //)
 //}
//})
// helper
 //const isSubscribed = (channel, room_id, user_id) => {
   //    const identifier = `{"channel":"${channel}","room_id":"${room_id}","user_id":"${user_id}"}`
     //  const subscription = consumer.subscriptions.findAll(identifier)
       //return !!subscription.length
    //}