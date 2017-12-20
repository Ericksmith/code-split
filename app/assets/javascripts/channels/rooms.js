App.global_chat = App.cable.subscriptions.create({
    channel: "ChatRoomsChannel",
    chat_room_id: ''
  }, {
    connected: function() {

    },
    disconnected: function() {

    },
    
    received(data) {
        return editor.append(data['code']);
    },

    send_message: function(code, room_id) {
      return this.perform('send_message', {
        code: code,
        room_id: room_id
      });
    }
  });