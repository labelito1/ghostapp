var audio = document.createElement('audio');
var audiosource = document.createElement('source');

var __artists__;
var __albums__;
var __tracks__;
var __queue__ = "";
var __nowplaying__ = -1;
var __nowplayingid__ = -1;
var __currentalbum__ = -1;

function shuffleArray(array) {
    for (var i = array.length - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

function getAlbum(id) {
    for (var i = 0; i < __albums__.length; i++) {
        if (__albums__[i].id == id) {
            return __albums__[i];
        }
    }
    return null;
};
function getTrack(id) {
    for (var i = 0; i < __tracks__.length; i++) {
        if (__tracks__[i].id == id) {
            return __tracks__[i];
        }
    }
    return null;
};
function getArtist(id) {
    for (var i = 0; i < __artists__.length; i++) {
        if (__artists__[i].id == id) {
            return __artists__[i];
        }
    }
    return null;
};

function queueAdd(id) {
    if (__queue__ != null || __queue__ != undefined) {
        var ids = __queue__.split(";");
        __queue__ = "";
        for (var i = 0; i < ids.length; i++) {
            __queue__ += ids[i] + ";";
            if (i == __nowplaying__) {
                __queue__ += id + ";";
            }
        }
        __queue__ = __queue__.substring(0, __queue__.length - 1);
    } else {
        __queue__ += id + ";";
    }
};

function queueAddList(list) {
    if (__queue__ != null || __queue__ != undefined) {
        var ids = list.split(";");
        __queue__ = "";
        for (var i = 0; i < ids.length; i++) {
            __queue__ += ids[i] + ";";
            if (i >= __nowplaying__) {
                __queue__ += id + ";";
            }
        }
        __queue__ = __queue__.substring(0, __queue__.length - 1);
    } else {
        __queue__ = list;
    }
};
function queueAddListEnd(list) {
    var ids = list.split(";");
    for (var i = 0; i < ids.length; i++) {
        __queue__ += ";" + ids[i];
    }
    __queue__ = __queue__.substring(0, __queue__.length - 1);
};

$(document).ready(function () {
    if (window.location.hostname == 'ghost.somee.com') {
        window.oncontextmenu = function (event) {
            event.preventDefault();
            event.stopPropagation();
            return false;
        };
    }
    getAudioFormat();
    fillArtists();
    adjustSize();
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