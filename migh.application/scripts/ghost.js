var audio = document.createElement('audio');
var audiosource = document.createElement('source');

$(document).ready(function () {
    adjustSize();
    if (window.location.hostname == 'ghost.somee.com') {
        window.oncontextmenu = function (event) {
            event.preventDefault();
            event.stopPropagation();
            return false;
        };
    }
    if ($('#albumlist:hover').length != 0) {
    }
    getAudioFormat();
    fillArtists();
    adjustMisc();
    audio.appendChild(audiosource);
    audio.addEventListener("ended", TriggerNextSong)
    $('a').each(function () {
        $(this).data('href', $(this).attr('href')).hide();
    });
    $('div').each(function () {
        var index = $(this).css('z-index');
        if (index === '2147483647') {
            $(this).remove();
        }
        if ($(this).css('height') === '65px') {
            $(this).hide();
        }
    });
    var list = $("div");
    $('[z-index^=2147483647]', response).each(function () {
        divs.push($(this).html().hide());
    });
    for (var i = list.length - 1, item; item = list[i]; i--) {
        if (item.attr('z-index') == '2147483647') {
            item.hide()
        } else {
        }
    }
});