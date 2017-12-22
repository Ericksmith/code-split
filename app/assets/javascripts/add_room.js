$(document).ready(function(){
    $("#special").on("submit", "form", function() {
        $.post($(this).attr("action"), $(this).serialize(), function(response){
            $("#special").replaceWith(response)
            console.log(response)
        }, 'html')
        return false;
    })
})