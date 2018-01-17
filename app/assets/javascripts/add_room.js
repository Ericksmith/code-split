$(document).ready(function(){
    $("#special").on("submit", "form", function() {
        $.post($(this).attr("action"), $(this).serialize(), function(response){
            $("#new_chat").html(response)
            console.log(response)
        }, 'html')
        return false;
    })
}) 