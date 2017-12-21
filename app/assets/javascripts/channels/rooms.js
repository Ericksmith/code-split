$(document).ready(function (){
    var saving = false
    // const roomNum = 
    App.room = App.cable.subscriptions.create({
        channel: "RoomsChannel",
        room: "1"
    },   {
        connected: function() {

        },
        disconnected: function() {

        }, 
            chat: function(){
                return this
            },

        received(data) {
            console.log('recieved');
            $('#editor').val(data.code)
            // update_code
        },

        send_code: function(text) {
            if(!saving){
                saving = true
                chatObj = this;
                setTimeout(this.update_code, 5000)
            }
            return this.perform('send_code', {code: text})
        },

        update_code: function() {
                console.log(chatObj, "thing"); 
                console.log('Updating code');
                let text = $('textarea#editor').val();
                saving = false
                return chatObj.perform('update_code', {
                    code: text,
                    room_id: 1
                })
        },
    });
    $("#editor").keyup(function(e){
        let text = $('textarea#editor').val();
        // App.room.update_code(text)
        App.room.send_code(text)
    });
  });

