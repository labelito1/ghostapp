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

var __prevalbum__;

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
    audio.addEventListener("ended", __next__);

    var img = document.getElementById('imgSongCoverTop');
    img.addEventListener('load', function () {
        var track = getTrack(__nowplayingid__);
        var album = getAlbum(track.album_id);

        if (__prevalbum__ != album.id) {
            __prevalbum__ = album.id;
            var vibrant = new Vibrant(img);
            var swatches = vibrant.swatches();
            for (var swatch in swatches) {
                if (swatches.hasOwnProperty(swatch) && swatches[swatch]) {
                    console.log(swatches['Muted'].getHex());
                    $('#lblSongArtist').css('color', swatches['Muted'].getTitleTextColor());
                    $('#lblSongTitle').css('color', swatches['Muted'].getTitleTextColor());
                    $('#lblSongAlbum').css('color', swatches['Muted'].getTitleTextColor());
                    $('#form1').css('background', 'linear-gradient(to bottom,' + swatches['Muted'].getHex() + ' 10%,#000000 90%');
                    var colors = swatches['Muted'].getRgb();
                    var result = 'rgba(' + colors[0] + ', ' + colors[1] + ', ' + colors[2] + ', 0.9)';
                    $('#topbar').css('background-color', result);
                    return;
                }
            }
            /*
             * Results into:
             * Vibrant #7a4426
             * Muted #7b9eae
             * DarkVibrant #348945
             * DarkMuted #141414
             * LightVibrant #f3ccb4
             */
        }
        
    });

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

function changeColor() {
    
}
function getBase64Image(img) {
    // Create an empty canvas element
    var canvas = document.createElement("canvas");
    canvas.width = img.width;
    canvas.height = img.height;

    // Copy the image contents to the canvas
    var ctx = canvas.getContext("2d");
    ctx.drawImage(img, 0, 0);

    // Get the data-URL formatted image
    // Firefox supports PNG and JPEG. You could check img.src to
    // guess the original format, but be aware the using "image/jpg"
    // will re-encode the image.
    var dataURL = canvas.toDataURL("image/png");

    return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
}