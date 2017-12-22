$(document).ready(function (){
    var saving = false
    const roomNum = $('#roomId').val()
    const userName = $("#user_name").val()
    App.room = App.cable.subscriptions.create({
        channel: "RoomsChannel",
        room: roomNum
    },   {
        connected: function() {
            return this.perform('new_user', {name: userName})
        },
        disconnected: function() {
            console.log('discon');
            return this.perform('user_left', {name: userName})
        }, 
            chat: function(){
                return this
            },

        received(data) {
            console.log('recieved');
            console.log(data);
            if(data.action == "send_code"){
                console.log('code');
                $('#editor').val(data.code)
            } else if (data.action == "new_user") {
                let radioButton = $('<input type="radio" name="typer" value="${data.name}">')
                radioButton.appendTo('#users')
            } else if (data.action == 'user_left'){
                console.log('leaver');
            }
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

