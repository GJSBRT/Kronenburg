var resourceName = "";
var soundPlayer = null;
function ChangeUi(uiname) { 
    $.get(`${uiname}/index.html`, function(data) {
        $("#elsui").html(data);
    }).fail(function(){});   
}

$(function () {
    window.addEventListener('message', function (event) {
        if (event.data.type == "initdata") {
            resourceName = event.data.name;
            ChangeUi(event.data.currentUI);
        } else if (event.data.type == "enableui") {
            document.body.style.display = event.data.enable ? "block" : "none";
        } else if (event.data.type == "click") {
            Click(cursorX - 1, cursorY - 1);
        } else if (event.data.type == "reload") {
            document.location.reload();
        } else if (event.data.type == "playsound") {
            if (soundPlayer != null) {
                soundPlayer.pause();
            }
            soundPlayer = new Howl({ src: [`./js/${event.data.sound}.ogg`] });
            soundPlayer.volume(event.data.volume);
            soundPlayer.play();
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post(`http://${resourceName}/escape`, JSON.stringify({}));
        }
    };

});