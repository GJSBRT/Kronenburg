window.addEventListener('message', function(event) {
        if (event.data.action == 'open') {
            $('.overlay').show()
            $('#loading-label').html(event.data.label)
            $('#loading-animation').animate({
                width: '100%'
            }, event.data.time, function() {
                $('#loading-animation').css({
                    'width': '0%'
                })
                $('.overlay').hide()
            })
        }
});

window.addEventListener('message', function(event) {
    if (event.data.action == 'close') {
        $('.overlay').hide()
    }
});
