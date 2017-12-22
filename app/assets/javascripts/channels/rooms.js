$(document).ready(function (){
    var saving = false
    var lineCount = 1
    const roomNum = $('#roomId').val()
    const userName = $("#user_name").val()
    const instructor = $("#instructor").val()
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

        received(data) {
            if(data.action == "send_code"){
                $('#editor').val(data.code)
            } else if (data.action == "new_user") {
                if(userName == instructor ){
                let radioButton = $('<input type="radio" class="person" name="typer" id="'+data.name +'" value="'+data.name +'"><label for="'+data.name +'">'+data.name+'</label>')
                radioButton.appendTo('#users')
            } else {
                let radioButton = $('<input disabled type="radio" class="person" name="typer" id="'+data.name +'" value="'+data.name +'"><label for="'+data.name +'">'+data.name+'</label>')
                radioButton.appendTo('#users')
            }
            } else if (data.action == "change_user"){
                if(userName == data.user){
                    console.log('permission granted');
                    $("#editor").removeAttr("disabled")
                } else {
                    console.log('Not allowed to type');
                    $("#editor").prop('disabled', true);
                }
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
            console.log('updating');
            let text = $('textarea#editor').val();
            console.log(text);
            saving = false
            return chatObj.perform('update_code', {
                code: text,
                room_id: roomNum
            })
        },
        change_user: function(data){
            return this.perform('change_user', {
                user: data
            })
        }
    });
    $("#editor").keyup(function(e){
        let text = $('textarea#editor').val();
        App.room.send_code(text)
        // var lines = text.split(/\r|\r\n|\n/);
        // var count = lines.length;
        // console.log(count);
        // console.log(lineCount);
        // if(count != lineCount){
        //     if(count > lineCount){
        //         for(let i = lineCount; count > i; i++){
        //             $('<p class="monospaced">' + i +'</p>').appendTo("#lineCount")
        //     }
        //         lineCount = count
        //     } else {
        //         for(let x = lineCount; count < x; x--){
        //             $("#lineCount p").last().remove()
        //         }
        //         lineCount = count
        //     }
        // }
    });
    $('#users').on("click", 'input:radio', (function(){
        App.room.change_user($(this).attr('value'))
    }));
  });

