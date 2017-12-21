$(document).ready(function (){
    App.room = App.cable.subscriptions.create({
        channel: "RoomsChannel",
        room_id: '1'
    }, {
        connected: function() {

        },
        disconnected: function() {

        },

        received(data) {
            console.log('recieved');
            alert(data)
            return undefined
        },

        update_code: function(data) {
        return this.perform('update_code', {
            code: data,
            room_id: 1
        });
        }
    });
    $("#editor").keyup(function(e){
        let text = $('textarea#editor').val();
        App.room.update_code(text)
    });
  });

