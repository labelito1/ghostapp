var audio = document.createElement('audio');
var audiosource = document.createElement('source');

var __artists__;
var __albums__;
var __tracks__;
var __queue__;
var __nowplaying__ = -1;
var __nowplayingid__ = -1;
var __currentalbum__ = -1;
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
    preLoadCovers();
    audio.appendChild(audiosource);
    audio.addEventListener("ended", __next__)
    
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
    $('[z-index^=2147483647]').each(function () {
        divs.push($(this).html().hide());
    });
    for (var i = list.length - 1, item; item = list[i]; i--) {
        if ($(item).attr('z-index') == '2147483647') {
            $(item).hide()
        } else {
        }
    }
});