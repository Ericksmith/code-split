$(document).ready(function (){
    var saving = false;
    var typist = 'null';
    const roomNum = $('#roomId').val();
    const userName = $("#user_name").val();
    const instructor = $("#instructor").val();
    const language = $("#language").val();
    App.room = App.cable.subscriptions.create({
        channel: "RoomsChannel",
        room: roomNum
    },   {
        connected: function() {
            return this.perform('new_user', {name: userName})
        },
        disconnected: function() {
            return this.perform('user_left', {name: userName})
        }, 
        received(data) {
            if(data.action == "send_code"){
                if(userName != typist){
                    myCodeMirror.setValue(data.code)
                }
            } else if (data.action == "new_user") {
                if(userName == instructor ){
                    let radioButtons = ""
                    for(var i = 0; i < data.all_users.length; i++){
                        radioButtons += '<div class="form-check" id=""><label class="form-check-label" for="'+data.all_users[i] +'"><input type="radio" class="form-check-input" name="typer" id="'+data.all_users[i] +'" value="'+data.all_users[i]+'">'+data.all_users[i]+'</label></div>'
                    }
                    $('.users').html(radioButtons)
            } else {
                let radioButtons = ""
                for(var i = 0; i < data.all_users.length; i++){
                    radioButtons += '<div class="form-check" id=""><label class="form-check-label" for="'+data.all_users[i] +'"><input disabled type="radio" class="form-check-input" name="typer" id="'+data.all_users[i] +'" value="'+data.all_users[i]+'">'+data.all_users[i]+'</label></div>'
                }
                $('.users').html(radioButtons)
            }
            } else if (data.action == "change_user"){
                typist = data.user;
                if(userName == data.user){
                    let msg = "<p class='chatMessage text-info'>" + data.user + " is now allowed to type in the editor</p>"
                    $(".chatBox").prepend(msg)
                    myCodeMirror.setOption("readOnly", false)
                    $("#" + data.user + "").prop("checked", true);
                } else {
                    let msg = "<p class='chatMessage text-info'>" + data.user + " is now allowed to type in the editor</p>"
                    $(".chatBox").prepend(msg)
                    myCodeMirror.setOption("readOnly", "nocursor" )
                    $("#" + data.user + "").prop("checked", true);
                }
            } else if (data.action == 'user_left'){
                console.log('leaver');
            } else if (data.action == "chat_message"){
                let msg = "<p class='chatMessage'>" + data.user + ": " + data.msg + "</p>"
                $(".chatBox").prepend(msg)
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
            let text = myCodeMirror.getValue();
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
        },
        send_message: function(text){
            return this.perform("chat_message", {
                msg: text,
                user: userName
            })
        }
    });
    $('.users').on("click", 'input:radio', (function(){
        if(typist != $(this).attr('value')){
            App.room.change_user($(this).attr('value'))
        }
    }));
    $("#chatMessage").keypress(function(e){
        if(e.which == 13){
            e.preventDefault();
            let msg = $("#chatMessage").val();
            if(msg.length > 0){
                App.room.send_message(msg)
                $("#chatMessage").val('')
            }
        }
    });
    console.log(language);
    var myCodeMirror = CodeMirror(document.getElementById("codeMirror"), {
        value: $('#startingCode').val(),
        lineNumbers: true,
        theme: "cobalt",
        mode:  language,
        readOnly: "nocursor"
    });
    myCodeMirror.on("keyup", function(cMirror){
        App.room.send_code(myCodeMirror.getValue());
    })
    $('[data-toggle="tooltip"]').tooltip(); 
});