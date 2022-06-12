import consumer from "./consumer"

document.addEventListener("turbolinks:load", () => {
  const data = document.getElementById("data")
  if (data === null) {
    return
  }
  const channel = "RoomChannel"
  const room_id = data.getAttribute("data-room-id")
  const user_id = data.getAttribute("data-user-id")
  if (!isSubscribed(channel. room_id, user_id)) {
    consumer.subscriptions.create(
      { channel: "RoomChannel", room_id: room_id, user_id: user_id },
      {
        connected() {
          // Called when the subscription is ready for use on the server
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          // Called when there's incoming data on the websocket for this channel
          const container = document.getElementById("container")
          container.insertAdjacentHTML('beforeend', data['chat_message'])
        }
      }
    )
  }
})

// helper
const isSubscribed = (channel, room_id, user_id) => {
  const identifier = `{"channel":"${channel}","room_id":"${room_id}","user_id":"${user_id}"}`
  const subscription = consumer.subscriptions.findAll(identifier)
  return !!subscription.length
}