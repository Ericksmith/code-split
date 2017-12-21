$(document).ready(function (){

    $("#editor").keyup(function(e){
        App.global_chat.send_message
    });

    App.global_chat = App.cable.subscriptions.create({
        channel: "RoomsChannel",
        room_id: '1'
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
    $("#editor").keyup(function(e){
        
    });
  });

