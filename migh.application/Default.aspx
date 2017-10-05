<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="migh.application.Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html id="xd" style="background-color: #20242b" xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="styles/ghost.css" rel="stylesheet" />
    <script src="scripts/Vibrant.min.js"></script>
    <%--<link href="scripts/jquery-ui.min.css" rel="stylesheet" />
    <script src="scripts/jquery-ui.min.js"></script>
    <script src="scripts/jquery.custom-animations.js"></script>--%>
    <script src="scripts/jquery.js"></script>
    <script src="scripts/ghost.js"></script>
    <%--<link rel="shortcut icon" type="image/png" href="images/music-player.png" />--%>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>--%>
    <style>
        ::-webkit-scrollbar {
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            border-radius: 4px;
            width: 0px;
            height: 0px;
        }
    </style>
<meta http-equiv="Content-Type" name="viewport" content="initial-scale=1, user-scalable=no"/>
    <title>ghost</title>
</head>
<body id="parentdiv" class="noselect" style="width: auto; background-repeat:repeat; background-attachment:fixed; background-size: 400px 400px">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div id="maindiv" class="panel panel-primary" style="background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 800px; margin-top:64px">
            <table id="coverTab" style="text-align:center; width:100%">
                <tr id="xddd" style="width:100%">
                    <td style="text-align: center; width:50%">
                        <div id="imgartistdiv">
                            <img id="imgArtist" alt="imgArtist" src="images/artist.png" style="box-shadow: 0px 0px 12px 0px rgba(0, 0, 0, 0.6)" />
                        </div>
                        <div style="margin-bottom:5px; margin-top:5px">
                            <label id="lblArtist" style="padding:6px; font-size:10px; border-radius:50px">Artista</label>
                        </div>
                    </td>
                </tr>
            </table>
            <asp:UpdatePanel ID="UpdatePanel2" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                    <table style="text-align:center; width:100%">
                        <tr style="width:100%; height:40px">
                            <td style="width:32px; text-align:left; vertical-align:middle">
                                <img style="height:24px; width:24px" src="images/artist.png" />
                            </td>
                            <td style="width:100%; height:40px">
                                <asp:DropDownList ID="listArtists" style="color:#FBFBFB; width:100%; height:100%; font-family:Verdana" runat="server" OnSelectedIndexChanged="listArtists_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div id="coverdiv" class="panel panel-primary" style="display:none; text-align:center; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px">
                <table id="tableImg" style="text-align: center; width:100%; border-spacing:0">
                    <tr style="-moz-border-radius: 10px; -webkit-border-radius: 10px;border-radius: 10px">
                        <td>
                            <ul id="albumlist" class="images" style="background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 600px">
                            </ul>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="listAlbums" />
                    <asp:AsyncPostBackTrigger ControlID="listSongs" />
                </Triggers> 
                <ContentTemplate>
                    <div id="combos" class="DivTableFormat" style="width: 100%">
                        <table style="text-align:center; width:100%; display:none">
                            <tr style="width:100%; height:40px">
                                <td style="width:32px; text-align:left; vertical-align:middle">
                                    <img style="height:24px; width:24px" src="images/album.png" />
                                </td>
                                <td style="width:100%; height:40px">
                                    <asp:DropDownList ID="listAlbums" style="color:#FBFBFB; background-color:#181818; border:none; width:100%; height:100%; font-family:Verdana" runat="server" OnSelectedIndexChanged="listAlbums_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table style="text-align:center; width:100%; display:none">
                            <tr style="width:100%; height:40px">
                                <td style="width:32px; text-align:left; vertical-align:middle">
                                    <img style="height:24px; width:24px" src="images/track.png" />
                                </td>
                                <td style="width:100%; height:40px">
                                    <asp:DropDownList ID="listSongs" style="color:#FBFBFB; background-color:#181818; border:none; width:100%; height:100%; font-family:Verdana" runat="server" AutoPostBack="true" OnSelectedIndexChanged="listSongs_SelectedIndexChanged"></asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div ></div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="parentTrackDiv" class="panel panel-primary" style="background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 800px">
            <div id="txtCurrentAlbum" class="panel panel-primary" style="text-align:center; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 800px; overflow:hidden">
            </div>
            <div id="tracksdiv" class="panel panel-primary" style="background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 800px">
                <table style="width:100%; border-spacing:0">
                    <tr>
                        <td style="text-align:left">
                            <ol id="tracklist" class="no-zoom">
                            </ol>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="height:90px; background-color: #20242b; visibility:hidden"> </div>
        <div id="topbar" class="nav-down">
            <table style="border-spacing:0px; width:100%; height:100%">
                <tr style="width:100%">
                    <td id="tdImg" style="text-align: left; width:65px">
                        <img id="imgSongCoverTop" alt="imgSongCover" crossOrigin="Anonymous" src="images/album.png" />
                    </td>
                    <td id="tdTag" style="text-align:left; width:100%; vertical-align:middle; height:100%">
                        <div style="height:100%; width:100%; display:grid">
                            <span style="display: inline-block; height: 100%; vertical-align: top; visibility:hidden"></span>
                            <label id="lblSongTitle" style="font-family:Verdana; font-size:10px; color:#FBFBFB">Título</label>
                            <label id="lblSongArtist" style="font-family:Verdana; font-size:10px; color:#97A09B">Artista</label>
                            <label id="lblSongAlbum" style="font-family:Verdana; font-size:10px; color:#FBFBFB">Álbum</label>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="resultdiv" class="panel panel-primary" style="display:none; text-align:left; background-color: #000000; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 100%; max-height: 300px; overflow-y: auto">
            <div style="width:auto">
               <ul id="searchlist" style="list-style-type: none">
                </ul>
           </div>
        </div>
        <div id="searchdiv" class="panel panel-primary" style="display:none; text-align:left; background-color: rgb(0, 0, 0); background-size:contain; background-position:center top; margin: 0 auto; max-width: 100%; max-height: 400px; overflow-y: auto">
            <div id="tdSearch" style="display:none; height: 100%; background-color: #000000" >
                <table style="width: 100%; height: 100%">
                <tr style="height:40%"></tr>
                <tr style="height: 60%">
                    
                    <td style="text-align:center; width:100%; vertical-align:middle; height: 70%">
                        <input placeholder="Buscar" autocomplete="off" type="text" id="txtSearch" onkeydown="if (window.event.keyCode == 13) 
                            {
                                Search(document.getElementById('txtSearch').value);
                                event.returnValue=false; 
                                event.cancel = true;
                                $('#txtSearch').blur();
                            }" 
                            style="text-align:left; color:#FBFBFB; font-family:Verdana; font-size:11px"/>
                    </td>
                    <td id="btnSearch" style="display:none; text-align: left; width:65px; vertical-align:middle; opacity:0.7">
                        <img style="height:20px; margin-top:5px; width:20px; margin-right:10px; margin-left:10px" src="images/up.png" />
                    </td>
                </tr>
            </table>
            </div>
        </div>
        <div id="optiondiv" class="panel panel-primary" style="display:none; text-align:center; background-size:contain; background-position:center top; width: 100% auto; margin: 0 auto; max-width: 100%">
            <table style="height:100%; width:100%">
                <tbody>
                    <tr>
                        <td style="width:33.3%; text-align:right">
                            <img alt="gotoalbum" src="images/album.png" style="width: 35px; height: 35px; vertical-align:middle"/>
                        </td>
                        <td style="width:33.3%; text-align:center">
                            <label id="lblAudioFormat" class="dark" style="padding:5px"></label>
                        </td>
                        <td style="width:33.3%; text-align:left">
                            <img alt="gotoartist" src="images/artist.png" style="width: 35px; height: 35px; vertical-align:middle"/>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="artistdiv">
            <ul id="artistlist" class="imagesArtist">            
            </ul>
        </div>
        <ul id="artistlist_temp" class="imagesArtist" style="display:none">            
        </ul>
        <ul id="albumlist_temp" class="imagesArtist" style="display:none">            
        </ul>
        <asp:HiddenField ID="nowplaying" runat="server" />
    </form>
    <div >
        <%--<div>
            <div style="background-color:#242a33; margin-left:2px; margin-right:2px;">
                <progress id="seekbar" value="0" max="1"></progress>
            </div>
        </div>--%>
        
    </div>
    <div id="footer">
        <div id="footerbar">
            <div style="margin-left:2px; margin-right:2px;">
                <progress id="seekbar" value="0" max="1"></progress>
            </div>
        </div>
        <div style="display:flex; pointer-events:none">
            <label id="currentTime" style="position:relative; pointer-events:none; z-index: 2; display:flex; font-family: verdana; font-size: 8px; color: #FBFBFB; margin-left:3px">00:00</label>
            <label id="duration"  style="position:relative; pointer-events:none; z-index: 2; display:flex; font-family: verdana; font-size: 8px; color: #FBFBFB; margin-right:3px">00:00</label>
        </div>
        
        <div style="position:relative; z-index: 5; text-align: center; height: 100%; display:inline-flex">
            <div>
                <img id="btnOpenArtists" src="images/ic_artist.png" style="width: 25px; height: 25px; margin-right:20px"/>
            </div>
            <div>
                <img id="mute" src="images/unmute.png" style="width: 21px; height: 21px; margin-right:20px"/>
            </div>
            <div>
                <img id="previous" src="images/previous.png" style="width: 25px; height: 25px; margin-right: 10px"/>
            </div>
            <div>
                <img id="play" src="images/play.png" style="width: 60px; height: 60px"/>
            </div>
            <div>
                <img id="next" src="images/next.png" style="width: 25px; height: 25px; margin-left: 10px"/>
            </div>
            <div>
                <img id="openmenu" src="images/menu.png" style="width: 21px; height: 21px; margin-left:20px"/>
            </div>
            <div>
                <img id="btnOpenSearch" src="images/ic_search.png" style="width: 25px; height: 25px; margin-left:20px"/>
            </div>
        </div>
    </div>
    
    <script>
        
        //(function ($) {
        //    $.dragScroll = function (options) {
        //        var settings = $.extend({
        //            scrollVertical: false,
        //            scrollHorizontal: true,
        //            cursor: null
        //        }, options);
        //        var clicked = false,
        //            clickY, clickX;
        //        var getCursor = function () {
        //            if (settings.cursor) return settings.cursor;
        //            if (settings.scrollVertical && settings.scrollHorizontal) return 'move';
        //            if (settings.scrollVertical) return 'row-resize';
        //            if (settings.scrollHorizontal) return 'col-resize';
        //        }
        //        var updateScrollPos = function (e, el) {
        //            //$(el).css('cursor', getCursor());
        //            var $el = $(el);
                    
        //            //settings.scrollVertical && $el.scrollTop($el.scrollTop() + (clickY - e.pageY));
        //            settings.scrollHorizontal && $el.scrollLeft($el.scrollLeft() + (clickX - e.pageX));
        //        }
        //        $('#albumlist').on({
        //            'mousemove': function (e) {
        //                if(clicked){
        //                    updateScrollPos(e, this);
        //                }
        //            },
        //            'mousedown': function (e) {
        //                clicked = true;
        //                clickY = e.pageY;
        //                clickX = e.pageX;
        //            },
        //            'mouseup': function () {
        //                clicked = false;

        //            }
        //        });
        //        $('#artistlist').on({
        //            'mousemove': function (e) {
        //                if(clicked){
        //                    updateScrollPos(e, this);
        //                }
        //            },
        //            'mousedown': function (e) {
        //                clicked = true;
        //                clickY = e.pageY;
        //                clickX = e.pageX;
        //            },
        //            'mouseup': function () {
        //                clicked = false;
                        
        //            }
        //        });
        //    }
        //}(jQuery))
        //$.dragScroll();

        (function() { 
            function scrollHorizontally(e) {
                var prev = false;
                e = window.event || e; 
                var delta = Math.max(-1, Math.min(1, (e.wheelDelta || -e.detail))); 
                if ($('#albumlist:hover').length != 0) {

                    //var scroll_w = parseInt(document.getElementById('albumlist').scrollWidth, 10);
                    //var width = parseInt($('#albumlist').css('width'), 10);
                    //var scroll = parseInt(document.getElementById('albumlist').scrollLeft, 10);

                    document.getElementById('albumlist').scrollLeft -= (delta * 80);
                    //var dif = (scroll_w - scroll) - width;
                    //if (dif > 1 && scroll > 0) {
                    //    prev = true;
                    //}
                    //document.getElementById('lblSongTitle').innerHTML = scroll;
                    //document.getElementById('lblSongArtist').innerHTML = scroll_w;
                    //document.getElementById('lblSongAlbum').innerHTML = width;
                    //document.getElementById('lblArtist').innerHTML = dif;
                }
                if($('#artistlist:hover').length != 0) {
                    document.getElementById('artistlist').scrollLeft -= (delta*80); 
                }
                // Multiplied by 40 
                
                    e.preventDefault();
                
                
            } 
            if (document.getElementById('albumlist').addEventListener) { 
                // IE9, Chrome, Safari, Opera 
                document.getElementById('albumlist').addEventListener("mousewheel", scrollHorizontally, false); 
                // Firefox 
                document.getElementById('albumlist').addEventListener("DOMMouseScroll", scrollHorizontally, false); 
            } else { 
                // IE 6/7/8 
                document.getElementById('albumlist').attachEvent("onmousewheel", scrollHorizontally); 
            } 
            if (document.getElementById('artistlist').addEventListener) { 
                // IE9, Chrome, Safari, Opera 
                document.getElementById('artistlist').addEventListener("mousewheel", scrollHorizontally, false); 
                // Firefox 
                document.getElementById('artistlist').addEventListener("DOMMouseScroll", scrollHorizontally, false); 
            } else { 
                // IE 6/7/8 
                document.getElementById('artistlist').attachEvent("onmousewheel", scrollHorizontally); 
            } 
        })();
        function Utils() {

        }
        Utils.prototype = {
            constructor: Utils,
            isElementInView: function (element, fullyInView) {
                var pageTop = $(window).scrollTop();
                var pageBottom = pageTop + $(window).height();
                var elementTop = $(element).offset().top;
                var elementBottom = elementTop + $(element).height();

                if (fullyInView === true) {
                    return ((pageTop < elementTop) && (pageBottom > elementBottom));
                } else {
                    return ((elementTop <= pageBottom) && (elementBottom >= pageTop));
                }
            }
        };
        //hide topbar
        var didScroll;
        var lastScrollTop = 0;
        var delta = 5;
        var navbarHeight = $('#topbar').outerHeight();
        var hidetopbar = true;
        $('#form1').scroll(function(event) {
            if(hidetopbar) {
                didScroll = true;
            }
        });

        setInterval(function() {
            if(didScroll){
                hasScrolled();
                didScroll = false;
            }
        }, 100);

        function hasScrolled() {
            var st = $('#form1').scrollTop();
            if(Math.abs(lastScrollTop - st) <= delta) {
                return;
            }
            if(st > lastScrollTop && st > navbarHeight) {
                $('#topbar').removeClass('nav-down').addClass('nav-up');
            } else {
                $('#topbar').removeClass('nav-up').addClass('nav-down');
            }
            lastScrollTop = st;
        }

        //window.addEventListener('scroll', function () {
        //    var top = document.getElementById('form1').scrollTop;
            
        //    document.getElementById('duration').innerHTML = top;
        //}, true)
        //fillcovers
        window.onresize = function (event) {
            var width = document.getElementById('maindiv').offsetWidth;
            $("#albumlist").css({
                "maxWidth": width - 15
            });
            adjustSize();
            adjustMisc();
        };
        function adjustMisc() {
            //duration label
            var dur = parseFloat($('#duration').css('width')) + 3;
            var cur = parseFloat($('#currentTime').css('width')) + 3;
            
            var m = parseInt($('#footer').css('width')) - (dur + cur);
            $('#duration').css('right', -m + 'px');

            //artistdiv - optiondiv margin bot
            var offset = parseInt($('#footerbar').offset().top);
            var body_height = parseInt($('body').css('height'));

            var margin_bot = body_height - offset;
            //$('#artistdiv').css('bottom', (margin_bot - 1) + 'px');
            $('#optiondiv').css('bottom', (margin_bot - 1) + 'px');
            $('#artistdiv').css('bottom', (margin_bot - 1) + 'px');
            $('#artistdiv').css('z-index', 5);

        }
        function adjustSize() {
            var width = document.getElementById('maindiv').offsetWidth;
            var parentwidth = document.getElementById('parentdiv').offsetWidth;
            var margin = (parentwidth - width)/2;
            if(parentwidth >= width) {
                $('#footer').css('max-width', width);
                $('#footer').css('left', margin);
                $('#footer').css('right', margin);
                $('#topbar').css('max-width', width);
                $('#topbar').css('left', margin);
                $('#topbar').css('right', margin);
                $('#artistdiv').css('max-width', width);
                $('#artistdiv').css('left', margin);
                $('#artistdiv').css('right', margin);
                $('#searchdiv').css('max-width', width + 2);
                $('#searchdiv').css('left', margin - 2);
                $('#searchdiv').css('right', margin - 2);
                $('#resultdiv').css('max-width', width + 2);
                $('#resultdiv').css('left', margin - 2);
                $('#resultdiv').css('right', margin - 2);
                $('#optiondiv').css('max-width', width);
                $('#optiondiv').css('left', margin);
                $('#optiondiv').css('right', margin);
                $('#footerbar').css('max-width', width);
                $('#footerbar').css('left', margin);
                $('#footerbar').css('right', margin);
            } else {
                $('#footer').css('max-width', '100%');
                $('#footer').css('left', 0);
                $('#footer').css('right', 0);
                $('#topbar').css('max-width', '100%');
                $('#topbar').css('left', 0);
                $('#topbar').css('right', 0);
                $('#artistdiv').css('max-width', '100%');
                $('#artistdiv').css('left', 0);
                $('#artistdiv').css('right', 0);
                $('#searchdiv').css('max-width', '100%');
                $('#searchdiv').css('left', 0);
                $('#searchdiv').css('right', 0);
                $('#resultdiv').css('max-width', '100%');
                $('#resultdiv').css('left', 0);
                $('#resultdiv').css('right', 0);
                $('#optiondiv').css('max-width', '100%');
                $('#optiondiv').css('left', 0);
                $('#optiondiv').css('right', 0);
                $('#footerbar').css('max-width', '100%');
                $('#footerbar').css('left', 0);
                $('#footerbar').css('right', 0);
            }
        }
        function fillCovers(srcs, albumnames, artistname, idlist, yearlist) {
            //$('#coverdiv').slideUp("slow");
            $('img').on('dragstart', function(event) { event.preventDefault(); });
            document.getElementById('albumlist').innerHTML = "";
            document.getElementById('coverdiv').style.display = 'inline';
            var ul = document.getElementById('albumlist');
            var width = document.getElementById('maindiv').offsetWidth;
            for (i = 0; i < srcs.length; i++) {
                    
                var li = document.createElement('li');
                li.style.padding = '6px';
                li.style.textAlign = '-webkit-center';
                var img = document.createElement('img');
                img.style.borderRadius = '0px';
                img.style.borderWidth = '2px';
                img.style.borderColor = '#242a33';
                img.style.borderStyle = 'solid';
                img.style.padding = '0px';
                //img.style.paddingBottom = '2px';
                var label = document.createElement('label');
                var year = document.createElement('label');
                label.className = 'searchtext';
                //label.style.fontWeight = "bold";
                label.style.width = '120px';
                label.style.fontSize = '10px';
                label.innerHTML = albumnames[i];
                label.style.paddingBottom = '3px';
                year.className = 'searchtext';
                //year.style.fontWeight = "bold";
                year.style.width = '100px';
                year.style.fontSize = '9px';
                year.style.paddingTop = '3px';
                year.innerHTML = yearlist[i];
                //year.style.paddingTop = '3px';

                img.alt = albumnames[i] + "@" + artistname + "@" + idlist[i];
                var a = document.createElement('div');
                a.style.display = 'inline-grid';

                img.setAttribute('type', 'albumitem');
                img.id = i;
                img.src = srcs[i].toString().replace("Cover.jpg", "CoverSmall.jpg");
                img.style.display = 'inline';
                img.width = '95';
                img.height = '95';
                li.appendChild(a);
                a.appendChild(label);
                a.appendChild(img);
                a.appendChild(year);
                ul.appendChild(li);
            }
            checkSelectedAlbum();
            var width = document.getElementById('maindiv').offsetWidth;
            $("#albumlist").css({
                "maxWidth": width - 15
            });
            $('#coverdiv').slideDown("slow", function(){
                var search = localStorage.getItem('searching');
                var search_id = localStorage.getItem('search_album_id');
                
                if(search == 'true') {
                    var albumlist = document.getElementById('albumlist');
                    var a_elements = albumlist.parentNode.getElementsByTagName("img");
                    for(i = 0; i < a_elements.length; i++) {
                        var alt = a_elements[i].getAttribute('alt');
                        
                        if(parseInt(alt.split('@')[2]) == search_id) {
                            var inner = document.getElementById('tracklist').innerHTML;
                            var albname = a_elements[i].getAttribute('alt').split('@')[0];
                            var artname = a_elements[i].getAttribute('alt').split('@')[1];
                            var albumlabel = document.createElement('label');
                            var artistlabel = document.createElement('label');
                            var br = document.createElement('br');
                            var guion = document.createElement('label');
                            albumlabel.className = 'light';
                            guion.className = 'dark';
                            artistlabel.className = 'dark';
                            guion.innerHTML = ' - ';
                            albumlabel.innerHTML = albname;
                            artistlabel.innerHTML = artname;
                            var txtcurrentalbum = document.getElementById('txtCurrentAlbum');
                            txtcurrentalbum.innerHTML = '';
                            txtcurrentalbum.appendChild(br);
                            txtcurrentalbum.appendChild(albumlabel);
                            txtcurrentalbum.appendChild(guion);
                            txtcurrentalbum.appendChild(artistlabel);
                            document.getElementById('parentTrackDiv').style.height = '600px';
                            document.getElementById('tracklist').innerHTML = '';
                            var id = parseInt(a_elements[i].getAttribute('id'));
                            document.getElementById('listAlbums').selectedIndex = id + 1;
                            __doPostBack('<%= listAlbums.UniqueID %>', '');
                            var offSet = localStorage.getItem("offSet");
                            document.getElementById('tracklist').style.marginBottom = '200px';
                            if (document.getElementById('tracklist').innerHTML == '') {
                                document.getElementById('tracklist').innerHTML = inner;
                            }
                        }
                    }
                }
                localStorage.setItem('searching', false);
            });
        }
        //
        function getEventTarget(e) {
            e = e || window.event;
            return e.target || e.srcElement;
        }
        //click tracklist
        //var goTop = document.getElementById('goTop');
        //goTop.onclick = function (event) {
        //    window.scrollTo(0, 0);
        //};
        //document.getElementById("txtSearch")
        //.addEventListener("keyup", function(event) {
        //    event.preventDefault();
        //    if (event.keyCode == 13) {
        //        alert('enter');
        //        var str = document.getElementById('txtSearch').value;
        //        Search(str);
        //        return false;
        //    }
        //});
        var btnOpenArtists = document.getElementById('btnOpenArtists');
        btnOpenArtists.onclick = function (event) {
            hideSearchBar();
            openArtists();
            unfade(btnOpenArtists);
        };
        function openArtists() {
            $('#optiondiv').hide();
            $('#artistdiv').toggle();
        }
        var btnSearch = document.getElementById('btnSearch');
        btnSearch.onclick = function (event) {
            unfade(btnSearch);

            hideSearchBar();
        };
        var lblArtist = document.getElementById('lblArtist');
        lblArtist.ondblclick = function (event) {
            $('#imgartistdiv').toggle();
        };
        var imgArtist = document.getElementById('imgArtist');
        imgArtist.onclick = function (event) {
            $('#artistdiv').toggle();
        };
        function hideSearchBar() {
            $( "#resultdiv" ).slideUp( "fast", function() {
                $('#tdSearch').slideUp("fast");
                $('#searchdiv').slideUp("fast");
            });
        }
        var btnopenmenu = document.getElementById('openmenu');
        btnopenmenu.onclick = function (event) {
            unfade(btnopenmenu);
            hideSearchBar();
            $('#artistdiv').hide();
            $('#optiondiv').toggle();
        }
        $(document).click(function(event){
            if ($('#artistdiv:hover').length == 0 && $('#footer:hover').length == 0 && $('#imgArtist:hover').length == 0) {
                $('#artistdiv').hide();
            }
            if($('#optiondiv:hover').length == 0 && $('#footer:hover').length == 0) {
                $('#optiondiv').hide();
            }
            if($('#resultdiv:hover').length == 0 && $('#searchdiv:hover').length == 0 && $('#tdSearch:hover').length == 0 && $('#footer:hover').length == 0) {
                if(document.getElementById('resultdiv').style.display.toString() !== 'none') {
                    $( "#resultdiv" ).slideUp( "fast");
                } else {
                    hideSearchBar();
                }
            }
        });
        var btnOpenSearch = document.getElementById('btnOpenSearch');
        btnOpenSearch.onclick = function (event) {
            $('#artistdiv').hide();
            $('#optiondiv').hide();
            var display = document.getElementById('searchdiv').style.display;
            if(display == 'none'){
                $('#searchdiv').slideToggle("fast");
                $('#tdSearch').slideToggle("fast", function(){
                    var searchlist = document.getElementById('searchlist');
                    var nodes = searchlist.parentNode.getElementsByTagName("div");
                    if(nodes.length > 0) {
                        $('#resultdiv').slideToggle("fast");
                    }
                    document.getElementById('txtSearch').focus();
                });
                
                
            }else{
                document.getElementById('txtSearch').focus();
                //hideSearchBar();
            }
            unfade(btnOpenSearch);
        };
        var mute = document.getElementById('mute');
        mute.onclick = function (event) {
            
            if(audio.muted){
                audio.muted = false;
                mute.src = 'images/unmute.png';
            }else{
                audio.muted = true;
                mute.src = 'images/mute.png';
            }
            unfade(mute);
        };
        var imgcover = document.getElementById('imgArtist');
        imgcover.ondblclick = function (event) {
            //window.scrollTo(0, 0);
            PageMethods.refreshLib(refresh);
            function refresh(response) {
                var list = JSON.parse(response);
                var drop = document.getElementsByName('listArtists');
                $(drop).empty();
                
                for(i = 0; i < list.length; i++) {
                    var option = document.createElement('option');
                    if(i == 0){
                        option.setAttribute('selected', 'selected');
                    }
                    option.setAttribute('value', list[i].id);
                    option.innerHTML = list[i].name;
                
                    $(drop).append(option);
                }
            }
        };
        ////x10
        var tdTag = document.getElementById('tdTag');
        tdTag.onclick = function (event) {
            var artistlistdiv = document.getElementById('artistlistdiv');
            if(artistlistdiv.style.width == '0px') {
                artistlistdiv.style.width = '160px';
            } else {
                artistlistdiv.style.width = '0px';
            }
        };
        var tdTag = document.getElementById('tdTag');
        tdTag.ondblclick = function (event) {
            goFullScreen();
        };
        function goFullScreen() {
            var fullscrn = document.getElementById("xd");
            var req = fullscrn.requestFullScreen || fullscrn.webkitRequestFullScreen || fullscrn.mozRequestFullScreen;
            req.call(fullscrn);
        }
        var optiondiv = document.getElementById('optiondiv');
        optiondiv.onclick = function(event) {
            var form = document.getElementById('form1');
            
            var target = getEventTarget(event);
            if (target.id == 'lblAudioFormat') {
                PageMethods.switchAudioFormat(setaudioformat);
                function setaudioformat() {
                    getAudioFormat();
                }
            }
            if (target.getAttribute('alt') == 'gotoartist') {
                try {
                    unfade(target);
                    var track = getTrack(__nowplayingid__);
                    var artist = getArtist(track.artist_id);
                    var target = getEventTarget(event);
                    var name = artist.name;
                    var image = artist.image;
                    var target = getEventTarget(event);
                    var id = parseInt(target.getAttribute('id'));
                    selectedArtist = artist.id;
                    document.getElementById('lblArtist').innerHTML = name;
                    document.getElementById('imgArtist').src = image;
                    document.getElementById('albumlist').innerHTML = "";
                    document.getElementById('coverdiv').style.display = 'inline';
                    var ul = document.getElementById('albumlist');
                    var width = document.getElementById('maindiv').offsetWidth;
                    for (i = 0; i < __albums__.length; i++) {
                        if (__albums__[i].artist_id == selectedArtist) {
                            var li = document.createElement('li');
                            li.style.padding = '6px';
                            li.style.textAlign = '-webkit-center';
                            var img = document.createElement('img');
                            img.style.borderRadius = '0px';
                            img.style.borderWidth = '2px';
                            img.style.borderColor = '#242a33';
                            img.style.borderStyle = 'solid';
                            img.style.padding = '0px';
                            //img.style.paddingBottom = '2px';
                            var label = document.createElement('label');
                            var year = document.createElement('label');
                            label.className = 'searchtext';
                            //label.style.fontWeight = "bold";
                            label.style.width = '120px';
                            label.style.fontSize = '10px';
                            label.innerHTML = __albums__[i].name;
                            label.style.paddingBottom = '3px';
                            year.className = 'searchtext';
                            //year.style.fontWeight = "bold";
                            year.style.width = '100px';
                            year.style.fontSize = '9px';
                            year.style.paddingTop = '3px';
                            year.innerHTML = __albums__[i].year;
                            //year.style.paddingTop = '3px';

                            img.alt = __albums__[i].name + "@" + __albums__[i].artist + "@" + __albums__[i].id;
                            var a = document.createElement('div');
                            a.style.display = 'inline-grid';

                            img.setAttribute('type', 'albumitem');
                            img.id = __albums__[i].id;
                            img.src = __albums__[i].cover.toString().replace("Cover.jpg", "CoverSmall.jpg");
                            img.style.display = 'inline';
                            img.width = '95';
                            img.height = '95';
                            li.appendChild(a);
                            a.appendChild(label);
                            a.appendChild(img);
                            a.appendChild(year);
                            ul.appendChild(li);
                        }
                    }
                    checkSelectedAlbum();
                    var width = document.getElementById('maindiv').offsetWidth;
                    $("#albumlist").css({
                        "maxWidth": width - 15
                    });
                    checkSelectedArtist();
                    $("#form1").animate({ scrollTop: 0 }, 0);
                } catch (err) {

                }
            }
            if (target.getAttribute('alt') == 'gotoalbum') {
                try {
                    unfade(target);
                    var track = getTrack(parseInt(__nowplayingid__));
                    var album = getAlbum(track.album_id);
                    var artist = getArtist(track.artist_id);
                    var inner = document.getElementById('tracklist').innerHTML;
                    var albname = album.name;
                    var artname = artist.name;

                    selectedAlbum = album.id;
                    var albumlabel = document.createElement('label');
                    var artistlabel = document.createElement('label');
                    var br = document.createElement('br');
                    var guion = document.createElement('label');
                    albumlabel.className = 'light';
                    guion.className = 'dark';
                    artistlabel.className = 'dark';
                    guion.innerHTML = ' - ';
                    albumlabel.innerHTML = albname;
                    artistlabel.innerHTML = artname;
                    var txtcurrentalbum = document.getElementById('txtCurrentAlbum');
                    txtcurrentalbum.innerHTML = '';
                    txtcurrentalbum.appendChild(br);
                    txtcurrentalbum.appendChild(albumlabel);
                    txtcurrentalbum.appendChild(guion);
                    txtcurrentalbum.appendChild(artistlabel);

                    document.getElementById('parentTrackDiv').style.height = '600px';
                    document.getElementById('tracklist').innerHTML = '';


                    var target = getEventTarget(event);
                    var id = album.id;

                <%-- document.getElementById('listAlbums').selectedIndex = id + 1;
                __doPostBack('<%= listAlbums.UniqueID %>', '');--%>
                    //new code :)
                    var ol = document.getElementById('tracklist');
                    //document.getElementById('tracklist').style.display = 'none';
                    document.getElementById('tracklist').innerHTML = "";
                    for (i = 0; i < __tracks__.length; i++) {
                        if (__tracks__[i].album_id == id) {
                            var li = document.createElement('li');

                            var img = document.createElement('img');
                            var tracknum = document.createElement('label');
                            tracknum.className = 'dark';
                            tracknum.innerHTML = __tracks__[i].tracknumber + '. ';
                            var duration = document.createElement('label');
                            var durationdiv = document.createElement('div');
                            var durationdivchild = document.createElement('div');

                            durationdiv.className = 'duration';
                            duration.className = 'dark';
                            duration.innerHTML = __tracks__[i].duration;
                            //duration.style.marginLeft = '78%';
                            //duration.style.cssFloat = 'right';
                            //duration.style.marginTop = '6px';
                            durationdivchild.appendChild(duration);
                            durationdiv.appendChild(durationdivchild);
                            //span
                            var helper = document.createElement('span');
                            helper.style.display = 'inline-block';
                            helper.style.height = '100%';
                            helper.style.verticalAlign = 'middle';
                            helper.style.visibility = 'hidden';
                            //<span style="display: inline-block; height: 100%; vertical-align: middle; visibility:hidden"></span>

                            //
                            img.id = __tracks__[i].id;
                            img.setAttribute('type', 'imgplay');
                            img.src = 'images/song.png';
                            img.width = 20;
                            img.height = 20;
                            img.style.verticalAlign = 'middle';
                            //img.style.marginBottom = '-8px';
                            li.style.verticalAlign = 'middle';
                            img.style.marginRight = '10px';
                            img.style.styleFloat = 'left';
                            li.setAttribute('alt', __tracks__[i].id);
                            //li.appendChild(img);
                            li.style.whiteSpace = 'nowrap';
                            //li.style.width = '90%';
                            var label = document.createElement('label');

                            label.style.display = 'inline-block';
                            label.style.maxWidth = '80%';
                            label.style.whiteSpace = 'normal';
                            label.setAttribute('type', 'imgplay');
                            label.id = __tracks__[i].id;
                            duration.id = __tracks__[i].id;
                            duration.setAttribute('type', 'imgplay');
                            label.innerHTML = __tracks__[i].name;
                            //li.appendChild(helper);
                            var div = document.createElement('div');
                            div.id = __tracks__[i].id;
                            div.style.height = '100%';
                            div.setAttribute('type', 'imgplay');
                            var helper = document.createElement('span');
                            helper.style.display = 'inline-block';
                            helper.style.height = '100%';
                            helper.style.verticalAlign = 'middle';
                            helper.style.visibility = 'hidden';
                            div.appendChild(helper);
                            div.appendChild(tracknum);
                            div.appendChild(label);
                            div.appendChild(durationdiv);
                            div.style.overflow = 'hidden';
                            li.style.verticalAlign = 'middle';
                            li.setAttribute('type', 'imgplay');
                            li.id = __tracks__[i].id;
                            div.addEventListener('dblclick', play_track)
                            li.appendChild(div);
                            //li.style.maxWidth = '400px';
                            ol.appendChild(li);
                        }

                    }
                    checkNowplaying();

                    document.getElementById('tracklist').style.marginBottom = '200px';
                    if (document.getElementById('tracklist').innerHTML == '') {
                        document.getElementById('tracklist').innerHTML = inner;
                    }
                    checkSelectedAlbum();
                    $("#form1").animate({ scrollTop: 410 }, 0);
                    setTimeout(function () {
                        $('#topbar').removeClass('nav-down').addClass('nav-up');
                    }, 100);
                    $('#topbar').removeClass('nav-down').addClass('nav-up');
                } catch (err) {

                }
            }
        }
        
        function play_track(event) {
            var target = getEventTarget(event);
            if (target.getAttribute('type') == 'imgplay') {
                __nowplaying__ = -1;
                var id = parseInt($(target).attr('id'));
                for (var i = 0; i < __tracks__.length; i++) {
                    var found = false;
                    var q = "";
                    if(__tracks__[i].id == id) {
                        var albumid = __tracks__[i].album_id;

                        for (var i = 0; i < __tracks__.length; i++) {
                            if (__tracks__[i].album_id == albumid) {
                                if (__tracks__[i].id == id) {
                                    found = true;
                                }
                                if (found) {
                                    q += __tracks__[i].id + ";";
                                }
                            }
                        }
                        try {
                            q = q.substring(0, q.length - 1);
                            __queue__ = q;
                            __next__();
                        } catch (err) {
                            console.log(err);
                        }
                        finally {
                            break;
                        }
                    }
                }
            }
        };
        //ul.addEventListener('touchend', preventZoom);
        
        var searchlist = document.getElementById('searchlist');
        searchlist.onclick = function (event) {
            var target = getEventTarget(event);
            var type = target.getAttribute('type');
            if (type === 'track') {
                //unfade(target);
                hideSearchBar();
                var id = parseInt($(target).attr('id'));
                for (var i = 0; i < __tracks__.length; i++) {
                    if (__tracks__[i].id == id) {
                        __nowplayingid__ = __tracks__[i].id;
                        var albumid = __tracks__[i].album_id;
                        queueAdd(__nowplayingid__);
                        __next__();

                        $(audiosource).attr('src', __tracks__[i].url);
                        setArtist(__tracks__[i].artist);
                        setAlbum(__tracks__[i].album);
                        setTitle(__tracks__[i].name);

                        var cover = "";
                        for (var j = 0; j < __albums__.length; j++) {
                            if (__albums__[j].id == __tracks__[i].album_id) {
                                cover = __albums__[j].cover;
                                break;
                            }
                        }
                        setCover(cover);
                        audio.load();
                        audio.play().then(updatemetadata);
                        checkNowplaying();
                        break;
                    }
                }
                checkNowplaying();
            }
            if (type === 'album') {
                selectedAlbum = parseInt(target.id);
                //unfade(target);
                var album = getAlbum(selectedAlbum);
                var artist = getArtist(album.artist_id);
                var inner = document.getElementById('tracklist').innerHTML;
                var albname = album.name;
                var artname = artist.name;

                selectedAlbum = parseInt(target.getAttribute('id'));
                var albumlabel = document.createElement('label');
                var artistlabel = document.createElement('label');
                var br = document.createElement('br');
                var guion = document.createElement('label');
                albumlabel.className = 'light';
                guion.className = 'dark';
                artistlabel.className = 'dark';
                guion.innerHTML = ' - ';
                albumlabel.innerHTML = albname;
                artistlabel.innerHTML = artname;
                var txtcurrentalbum = document.getElementById('txtCurrentAlbum');
                txtcurrentalbum.innerHTML = '';
                txtcurrentalbum.appendChild(br);
                txtcurrentalbum.appendChild(albumlabel);
                txtcurrentalbum.appendChild(guion);
                txtcurrentalbum.appendChild(artistlabel);

                document.getElementById('parentTrackDiv').style.height = '600px';
                document.getElementById('tracklist').innerHTML = '';


                var target = getEventTarget(event);
                var id = album.id;

                <%-- document.getElementById('listAlbums').selectedIndex = id + 1;
                __doPostBack('<%= listAlbums.UniqueID %>', '');--%>
                //new code :)
                var ol = document.getElementById('tracklist');
                $("#form1").animate({ scrollTop: 410 }, 0);
                //document.getElementById('tracklist').style.display = 'none';
                document.getElementById('tracklist').innerHTML = "";
                for (i = 0; i < __tracks__.length; i++) {
                    if (__tracks__[i].album_id == id) {
                        var li = document.createElement('li');

                        var img = document.createElement('img');
                        var tracknum = document.createElement('label');
                        tracknum.className = 'dark';
                        tracknum.innerHTML = __tracks__[i].tracknumber + '. ';
                        var duration = document.createElement('label');
                        var durationdiv = document.createElement('div');
                        var durationdivchild = document.createElement('div');

                        durationdiv.className = 'duration';
                        duration.className = 'dark';
                        duration.innerHTML = __tracks__[i].duration;
                        //duration.style.marginLeft = '78%';
                        //duration.style.cssFloat = 'right';
                        //duration.style.marginTop = '6px';
                        durationdivchild.appendChild(duration);
                        durationdiv.appendChild(durationdivchild);
                        //span
                        var helper = document.createElement('span');
                        helper.style.display = 'inline-block';
                        helper.style.height = '100%';
                        helper.style.verticalAlign = 'middle';
                        helper.style.visibility = 'hidden';
                        //<span style="display: inline-block; height: 100%; vertical-align: middle; visibility:hidden"></span>

                        //
                        img.id = __tracks__[i].id;
                        img.setAttribute('type', 'imgplay');
                        img.src = 'images/song.png';
                        img.width = 20;
                        img.height = 20;
                        img.style.verticalAlign = 'middle';
                        //img.style.marginBottom = '-8px';
                        li.style.verticalAlign = 'middle';
                        img.style.marginRight = '10px';
                        img.style.styleFloat = 'left';
                        li.setAttribute('alt', __tracks__[i].id);
                        //li.appendChild(img);
                        li.style.whiteSpace = 'nowrap';
                        //li.style.width = '90%';
                        var label = document.createElement('label');

                        label.style.display = 'inline-block';
                        label.style.maxWidth = '80%';
                        label.style.whiteSpace = 'normal';
                        label.setAttribute('type', 'imgplay');
                        label.id = __tracks__[i].id;
                        duration.id = __tracks__[i].id;
                        duration.setAttribute('type', 'imgplay');
                        label.innerHTML = __tracks__[i].name;
                        //li.appendChild(helper);
                        var div = document.createElement('div');
                        div.id = __tracks__[i].id;
                        div.style.height = '100%';
                        div.setAttribute('type', 'imgplay');
                        var helper = document.createElement('span');
                        helper.style.display = 'inline-block';
                        helper.style.height = '100%';
                        helper.style.verticalAlign = 'middle';
                        helper.style.visibility = 'hidden';
                        div.appendChild(helper);
                        div.appendChild(tracknum);
                        div.appendChild(label);
                        div.appendChild(durationdiv);
                        div.style.overflow = 'hidden';
                        li.style.verticalAlign = 'middle';
                        li.setAttribute('type', 'imgplay');
                        li.id = __tracks__[i].id;
                        div.addEventListener('dblclick', play_track)
                        li.appendChild(div);
                        //li.style.maxWidth = '400px';
                        ol.appendChild(li);
                    }

                }
                checkNowplaying();

                document.getElementById('tracklist').style.marginBottom = '200px';
                if (document.getElementById('tracklist').innerHTML == '') {
                    document.getElementById('tracklist').innerHTML = inner;
                }
                checkSelectedAlbum();
                hideSearchBar();
                setTimeout(function () {
                    $('#topbar').removeClass('nav-down').addClass('nav-up');
                }, 300);
            }
            
            if (type === 'artist') {
                selectedArtist = parseInt(target.id);
                var form = document.getElementById('form1');
                //unfade(target);
                $( "#resultdiv" ).slideUp( "fast", function() {
                    $('#tdSearch').slideUp("fast");
                    $('#searchdiv').slideUp("fast");

                    
                });
                var speed = 0;
                var top = parseInt(document.getElementById('form1').scrollTop);
                if(top == 0) {
                    speed = 0;
                }
                $(form).animate({ scrollTop: 0 }, 0);
                try {
                    var target = getEventTarget(event);
                    if (target.getAttribute('type') == 'artist') {
                        var speed = 0;
                        var top = parseInt(document.getElementById('form1').scrollTop);
                        if (top == 0) {
                            speed = 0;
                        }
                        $('#form1').animate({ scrollTop: 0 }, 0);
                        var artist = getArtist(selectedArtist);
                        var target = getEventTarget(event);
                        var name = artist.name;
                        var image = artist.image;
                        var target = getEventTarget(event);
                        var id = parseInt(target.getAttribute('id'));
                        document.getElementById('lblArtist').innerHTML = name;
                        document.getElementById('imgArtist').src = image;
                        document.getElementById('albumlist').innerHTML = "";
                        document.getElementById('coverdiv').style.display = 'inline';
                        var ul = document.getElementById('albumlist');
                        var width = document.getElementById('maindiv').offsetWidth;
                        for (i = 0; i < __albums__.length; i++) {
                            if (__albums__[i].artist_id == selectedArtist) {
                                var li = document.createElement('li');
                                li.style.padding = '6px';
                                li.style.textAlign = '-webkit-center';
                                var img = document.createElement('img');
                                img.style.borderRadius = '0px';
                                img.style.borderWidth = '2px';
                                img.style.borderColor = '#242a33';
                                img.style.borderStyle = 'solid';
                                img.style.padding = '0px';
                                //img.style.paddingBottom = '2px';
                                var label = document.createElement('label');
                                var year = document.createElement('label');
                                label.className = 'searchtext';
                                //label.style.fontWeight = "bold";
                                label.style.width = '120px';
                                label.style.fontSize = '10px';
                                label.innerHTML = __albums__[i].name;
                                label.style.paddingBottom = '3px';
                                year.className = 'searchtext';
                                //year.style.fontWeight = "bold";
                                year.style.width = '100px';
                                year.style.fontSize = '9px';
                                year.style.paddingTop = '3px';
                                year.innerHTML = __albums__[i].year;
                                //year.style.paddingTop = '3px';

                                img.alt = __albums__[i].name + "@" + __albums__[i].artist + "@" + __albums__[i].id;
                                var a = document.createElement('div');
                                a.style.display = 'inline-grid';

                                img.setAttribute('type', 'albumitem');
                                img.id = __albums__[i].id;
                                img.src = __albums__[i].cover.toString().replace("Cover.jpg", "CoverSmall.jpg");
                                img.style.display = 'inline';
                                img.width = '95';
                                img.height = '95';
                                li.appendChild(a);
                                a.appendChild(label);
                                a.appendChild(img);
                                a.appendChild(year);
                                ul.appendChild(li);
                            }
                        }
                        checkSelectedAlbum();
                        var width = document.getElementById('maindiv').offsetWidth;
                        $("#albumlist").css({
                            "maxWidth": width - 15
                        });
                        checkSelectedArtist();
                        hideSearchBar();
                    }
                } catch (err) {
                    console.log(err);
                }
                checkSelectedArtist();
                //hideSearchBar();
            }
        };
        function selectAlbum(album_id) {
            var albumlist = document.getElementById('albumlist');
            var a_elements = albumlist.parentNode.getElementsByTagName("img");
            for(i = 0; i < a_elements.length; i++) {
                var alt = a_elements[i].getAttribute('alt');
                
                if(parseInt(alt.split('@')[2]) == album_id) {
                    var inner = document.getElementById('tracklist').innerHTML;
                    var albname = a_elements[i].getAttribute('alt').split('@')[0];
                    var artname = a_elements[i].getAttribute('alt').split('@')[1];
                    var albumlabel = document.createElement('label');
                    var artistlabel = document.createElement('label');
                    var br = document.createElement('br');
                    var guion = document.createElement('label');
                    albumlabel.className = 'light';
                    guion.className = 'dark';
                    artistlabel.className = 'dark';
                    guion.innerHTML = ' - ';
                    albumlabel.innerHTML = albname;
                    artistlabel.innerHTML = artname;
                    var txtcurrentalbum = document.getElementById('txtCurrentAlbum');
                    txtcurrentalbum.innerHTML = '';
                    txtcurrentalbum.appendChild(br);
                    txtcurrentalbum.appendChild(albumlabel);
                    txtcurrentalbum.appendChild(guion);
                    txtcurrentalbum.appendChild(artistlabel);
                    document.getElementById('parentTrackDiv').style.height = '600px';
                    document.getElementById('tracklist').innerHTML = '';
                    var id = parseInt(a_elements[i].getAttribute('id'));
                    document.getElementById('listAlbums').selectedIndex = id + 1;
                    __doPostBack('<%= listAlbums.UniqueID %>', '');
                    var offSet = localStorage.getItem("offSet");
                    document.getElementById('tracklist').style.marginBottom = '200px';
                    if (document.getElementById('tracklist').innerHTML == '') {
                        document.getElementById('tracklist').innerHTML = inner;
                    }
                    break;
                }
            }
        }
        //
        //get scroll dis
        function dw_getScrollOffsets() {
            var doc = document, w = window;
            var x, y, docEl;

            if (typeof w.pageYOffset === 'number') {
                x = w.pageXOffset;
                y = w.pageYOffset;
            } else {
                docEl = (doc.compatMode && doc.compatMode === 'CSS1Compat') ?
                        doc.documentElement : doc.body;
                x = docEl.scrollLeft;
                y = docEl.scrollTop;
            }
            return { x: x, y: y };
        }
        var selectedAlbum = -1;
        function checkSelectedAlbum() {
            var albumlist = document.getElementById('albumlist');
            var items = albumlist.getElementsByTagName('img');
            for (i = 0; i < items.length; i++) {
                var itemid = parseInt(items[i].getAttribute('alt').split('@')[2]);
                if (itemid == selectedAlbum) {
                    items[i].style.borderColor = 'white';
                    //items[i].style.boxShadow = 'rgba(0, 106, 205, 0.31) 0px 0px 20px 0px';
                } else {
                    items[i].style.borderColor = '#242a33';
                    //items[i].style.boxShadow = 'rgba(0, 0, 0, 0.6) 0px 0px 20px 0px';
                }
            }
        }
        var selectedArtist = -1;
        function checkSelectedArtist() {
            var artistlist = document.getElementById('artistlist');
            var items = artistlist.getElementsByTagName('img');
            for (i = 0; i < items.length; i++) {
                var itemid = parseInt(items[i].getAttribute('alt').split('@')[2]);
                if (itemid == selectedArtist) {
                    items[i].style.borderColor = 'white';
                    //items[i].style.boxShadow = 'rgba(0, 106, 205, 0.31) 0px 0px 20px 0px';
                } else {
                    items[i].style.borderColor = '#373f4c';
                    //items[i].style.boxShadow = 'rgba(0, 0, 0, 0.6) 0px 0px 20px 0px';
                }
            }
        }
        //
        //click albumlist
        var ulalbum = document.getElementById('albumlist');
        ulalbum.onclick = function (event) {
            var target = getEventTarget(event);
            if (target.getAttribute('type') == 'albumitem') {
                var inner = document.getElementById('tracklist').innerHTML;
                var albname = target.getAttribute('alt').split('@')[0];
                var artname = target.getAttribute('alt').split('@')[1];

                selectedAlbum = parseInt(target.getAttribute('id'));
                var albumlabel = document.createElement('label');
                var artistlabel = document.createElement('label');
                var br = document.createElement('br');
                var guion = document.createElement('label');
                albumlabel.className = 'light';
                guion.className = 'dark';
                artistlabel.className = 'dark';
                guion.innerHTML = ' - ';
                albumlabel.innerHTML = albname;
                artistlabel.innerHTML = artname;
                var txtcurrentalbum = document.getElementById('txtCurrentAlbum');
                txtcurrentalbum.innerHTML = '';
                txtcurrentalbum.appendChild(br);
                txtcurrentalbum.appendChild(albumlabel);
                txtcurrentalbum.appendChild(guion);
                txtcurrentalbum.appendChild(artistlabel);

                document.getElementById('parentTrackDiv').style.height = '600px';
                document.getElementById('tracklist').innerHTML = '';


                var target = getEventTarget(event);
                var id = parseInt(target.getAttribute('id'));

                <%-- document.getElementById('listAlbums').selectedIndex = id + 1;
                __doPostBack('<%= listAlbums.UniqueID %>', '');--%>
                //new code :)
                var ol = document.getElementById('tracklist');
                //document.getElementById('tracklist').style.display = 'none';
                document.getElementById('tracklist').innerHTML = "";
                for (i = 0; i < __tracks__.length; i++) {
                    if (__tracks__[i].album_id == id) {
                        var li = document.createElement('li');

                        var img = document.createElement('img');
                        var tracknum = document.createElement('label');
                        tracknum.className = 'dark';
                        tracknum.innerHTML = __tracks__[i].tracknumber + '. ';
                        var duration = document.createElement('label');
                        var durationdiv = document.createElement('div');
                        var durationdivchild = document.createElement('div');

                        durationdiv.className = 'duration';
                        duration.className = 'dark';
                        duration.innerHTML = __tracks__[i].duration;
                        //duration.style.marginLeft = '78%';
                        //duration.style.cssFloat = 'right';
                        //duration.style.marginTop = '6px';
                        durationdivchild.appendChild(duration);
                        durationdiv.appendChild(durationdivchild);
                        //span
                        var helper = document.createElement('span');
                        helper.style.display = 'inline-block';
                        helper.style.height = '100%';
                        helper.style.verticalAlign = 'middle';
                        helper.style.visibility = 'hidden';
                        //<span style="display: inline-block; height: 100%; vertical-align: middle; visibility:hidden"></span>

                        //
                        img.id = __tracks__[i].id;
                        img.setAttribute('type', 'imgplay');
                        //img.src = 'images/song.png';
                        img.width = 20;
                        img.height = 20;
                        img.style.verticalAlign = 'middle';
                        //img.style.marginBottom = '-8px';
                        li.style.verticalAlign = 'middle';
                        img.style.marginRight = '10px';
                        img.style.styleFloat = 'left';
                        li.setAttribute('alt', __tracks__[i].id);
                        //li.appendChild(img);
                        li.style.whiteSpace = 'nowrap';
                        //li.style.width = '90%';
                        var label = document.createElement('label');

                        label.style.display = 'inline-block';
                        label.style.maxWidth = '80%';
                        label.style.whiteSpace = 'normal';
                        label.setAttribute('type', 'imgplay');
                        label.id = __tracks__[i].id;
                        duration.id = __tracks__[i].id;
                        duration.setAttribute('type', 'imgplay');
                        label.innerHTML = __tracks__[i].name;
                        //li.appendChild(helper);
                        var div = document.createElement('div');
                        div.id = __tracks__[i].id;
                        div.style.height = '100%';
                        div.setAttribute('type', 'imgplay');
                        var helper = document.createElement('span');
                        helper.style.display = 'inline-block';
                        helper.style.height = '100%';
                        helper.style.verticalAlign = 'middle';
                        helper.style.visibility = 'hidden';
                        div.appendChild(helper);
                        div.appendChild(tracknum);
                        div.appendChild(label);
                        div.appendChild(durationdiv);
                        div.style.overflow = 'hidden';
                        li.style.verticalAlign = 'middle';
                        li.setAttribute('type', 'imgplay');
                        li.id = __tracks__[i].id;
                        div.addEventListener('dblclick', play_track)
                        li.appendChild(div);
                        //li.style.maxWidth = '400px';
                        ol.appendChild(li);
                    }
                    
                }
                checkNowplaying();

                document.getElementById('tracklist').style.marginBottom = '200px';
                if (document.getElementById('tracklist').innerHTML == '') {
                    document.getElementById('tracklist').innerHTML = inner;
                }
                checkSelectedAlbum();
            }
        };
        var ulartist = document.getElementById('artistdiv');
        ulartist.onclick = function (event) {
            try {
                var target = getEventTarget(event);
                if (target.getAttribute('type') == 'artist') {
                    //unfade(target);
                    selectedArtist = parseInt(target.getAttribute('alt').split('@')[2]);
                    var speed = 0;
                    var top = parseInt(document.getElementById('form1').scrollTop);
                    if (top == 0) {
                        speed = 0;
                    }
                    $('#form1').animate({ scrollTop: 0 }, 0);
                    var target = getEventTarget(event);
                    var name = target.getAttribute('alt').split('@')[0];
                    var image = target.getAttribute('alt').split('@')[1];
                    var target = getEventTarget(event);
                    var id = parseInt(target.getAttribute('id'));
                    document.getElementById('lblArtist').innerHTML = name;
                    document.getElementById('imgArtist').src = image;
                    //document.getElementById('listArtists').selectedIndex = id + 1;
                    <%--//__doPostBack('<%= listAlbums.UniqueID %>', '');--%>
                    //new code :)
                    document.getElementById('albumlist').innerHTML = "";
                    document.getElementById('coverdiv').style.display = 'inline';
                    var ul = document.getElementById('albumlist');
                    var width = document.getElementById('maindiv').offsetWidth;
                    for (i = 0; i < __albums__.length; i++) {
                        if (__albums__[i].artist_id == selectedArtist) {
                            var li = document.createElement('li');
                            li.style.padding = '6px';
                            li.style.textAlign = '-webkit-center';
                            var img = document.createElement('img');
                            img.style.borderRadius = '0px';
                            img.style.borderWidth = '2px';
                            img.style.borderColor = 'white';
                            img.style.borderStyle = 'solid';
                            img.style.padding = '0px';
                            //img.style.paddingBottom = '2px';
                            var label = document.createElement('label');
                            var year = document.createElement('label');
                            label.className = 'searchtext';
                            //label.style.fontWeight = "bold";
                            label.style.width = '120px';
                            label.style.fontSize = '10px';
                            label.innerHTML = __albums__[i].name;
                            label.style.paddingBottom = '3px';
                            year.className = 'searchtext';
                            //year.style.fontWeight = "bold";
                            year.style.width = '100px';
                            year.style.fontSize = '9px';
                            year.style.paddingTop = '3px';
                            year.innerHTML = __albums__[i].year;
                            //year.style.paddingTop = '3px';

                            img.alt = __albums__[i].name + "@" + __albums__[i].artist + "@" + __albums__[i].id;
                            var a = document.createElement('div');
                            a.style.display = 'inline-grid';

                            img.setAttribute('type', 'albumitem');
                            img.id = __albums__[i].id;
                            img.src = __albums__[i].cover.toString().replace("Cover.jpg", "CoverSmall.jpg");
                            img.style.display = 'inline';
                            img.width = '97';
                            img.height = '97';
                            img.style.padding = '2px';
                            li.appendChild(a);
                            a.appendChild(label);
                            a.appendChild(img);
                            a.appendChild(year);
                            ul.appendChild(li);
                        }
                    }
                    checkSelectedAlbum();
                    var width = document.getElementById('maindiv').offsetWidth;
                    $("#albumlist").css({
                        "maxWidth": width - 15
                    });
                    checkSelectedArtist();
                }
            } catch (err) {

            }
            
        };
        //ulartist
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function (s, e) {
            var offSet = localStorage.getItem("offSet");
            //window.scrollTo(0, offSet);

        });
        //
        function checkNowplaying() {
            try {
                var tracklist = document.getElementById('tracklist');
                var items = tracklist.getElementsByTagName('li');
                for (i = 0; i < items.length; i++) {
                    var itemid = parseInt(items[i].getAttribute('alt'));
                    if (itemid == parseInt(__nowplayingid__)) {
                        items[i].style.borderColor = '#004463';
                        items[i].style.backgroundColor = '#2c323c';
                    } else {
                        items[i].style.backgroundColor = 'black';
                        items[i].style.borderColor = '#2c323c';
                    }
                }
            }catch(err) {

            }
            
        }
        function playTrack(tracklist, idlist, durations, tracknumbers, performerlist) {
            //$("#tracklist").slideUp();
                
            var ol = document.getElementById('tracklist');
            //document.getElementById('tracklist').style.display = 'none';
            document.getElementById('tracklist').innerHTML = "";
            for (i = 0; i < tracklist.length; i++) {
                var li = document.createElement('li');

                var img = document.createElement('img');
                var tracknum = document.createElement('label');
                tracknum.className = 'dark';
                tracknum.innerHTML = tracknumbers[i] + '. '; 
                var duration = document.createElement('label');
                var durationdiv = document.createElement('div');
                var durationdivchild = document.createElement('div');
                
                durationdiv.className = 'duration';
                duration.className = 'dark';
                duration.innerHTML = durations[i]; 
                //duration.style.marginLeft = '78%';
                //duration.style.cssFloat = 'right';
                //duration.style.marginTop = '6px';
                durationdivchild.appendChild(duration);
                durationdiv.appendChild(durationdivchild);
                //span
                var helper = document.createElement('span');
                helper.style.display = 'inline-block';
                helper.style.height = '100%';
                helper.style.verticalAlign = 'middle';
                helper.style.visibility = 'hidden';
                //<span style="display: inline-block; height: 100%; vertical-align: middle; visibility:hidden"></span>

                //
                img.id = i;
                img.setAttribute('type', 'imgplay');
                img.src = 'images/song.png';
                img.width = 20;
                img.height = 20;
                img.style.verticalAlign = 'middle';
                //img.style.marginBottom = '-8px';
                li.style.verticalAlign = 'middle';
                img.style.marginRight = '10px';
                img.style.styleFloat = 'left';
                li.setAttribute('alt', idlist[i]);
                //li.appendChild(img);
                li.style.whiteSpace = 'nowrap';
                //li.style.width = '90%';
                var label = document.createElement('label');
                
                label.style.display = 'inline-block';
                label.style.maxWidth = '80%';
                label.style.whiteSpace = 'normal';
                label.setAttribute('type', 'imgplay');
                label.id = i;
                duration.id = i;
                duration.setAttribute('type', 'imgplay');
                label.innerHTML = tracklist[i];
                //li.appendChild(helper);
                var div = document.createElement('div');
                div.id = i;
                div.style.height = '100%';
                div.setAttribute('type', 'imgplay');
                var helper = document.createElement('span');
                helper.style.display = 'inline-block';
                helper.style.height = '100%';
                helper.style.verticalAlign = 'middle';
                helper.style.visibility = 'hidden';
                div.appendChild(helper);
                div.appendChild(tracknum);
                div.appendChild(label);
                div.appendChild(durationdiv);
                div.style.overflow = 'hidden';
                li.style.verticalAlign = 'middle';
                li.setAttribute('type', 'imgplay');
                li.id = i;
                div.addEventListener('dblclick', play_track)
                li.appendChild(div);
                //li.style.maxWidth = '400px';
                ol.appendChild(li);
            }
            checkNowplaying();
            //$("#tracklist").slideDown();
        }
        window.onbeforeunload = function() {
            
            return "Dude, are you sure you want to leave? Think of the kittens!";
        }
        function getAllElementsWithAttribute(attribute)
        {
            var matchingElements = [];
            var allElements = document.getElementsByTagName('*');
            for (var i = 0, n = allElements.length; i < n; i++)
            {
                if (allElements[i].getAttribute(attribute) !== null)
                {
                    // Element exists with attribute. Add to array.
                    matchingElements.push(allElements[i]);
                }
            }
            
            return matchingElements;
        }
        
        (function (global) { 

            if(typeof (global) === "undefined") {
                throw new Error("window is undefined");
            }

            var _hash = "!";
            var noBackPlease = function () {
                global.location.href += "#";
                // making sure we have the fruit available for juice (^__^)
                global.setTimeout(function () {
                    global.location.href += "!";
                }, 50);
            };

            global.onhashchange = function () {
                
                //checkMenus();
                if (global.location.hash !== _hash) {
                    global.location.hash = _hash;
                }
            };

            global.onload = function () {            
                noBackPlease();
                // disables backspace on page except on input fields and textarea..
                document.body.onkeydown = function (e) {
                    var elm = e.target.nodeName.toLowerCase();
                    if (e.which === 8 && (elm !== 'input' && elm  !== 'textarea')) {
                        e.preventDefault();
                    }
                    // stopping event bubbling up the DOM tree..
                    e.stopPropagation();
                };          
            }

        })(window);
        function checkMenus() {
            hideSearchBar();
            $('#optiondiv').hide();
            $('#artistdiv').hide();
        }
        //window.oncontextmenu = function(event) {
        //    event.preventDefault();
        //    event.stopPropagation();
        //    return false;
        //};
        function getAudioFormat() {
            var audioformat = getCookie('audioformat');
            document.getElementById('lblAudioFormat').innerHTML = audioformat;
        }

        function fillArtists() {
            document.getElementById('artistlist').innerHTML = "";
            //document.getElementById('artistdiv').style.display = 'inline';
            var ul = document.getElementById('artistlist');
            var ul_temp = document.getElementById('artistlist_temp');
            PageMethods.getArtists(fill, failed);
            function failed() {
                alert("Error al cargar artistas.");
            }
            function fill(response) {
                var list = JSON.parse(response);
                for (i = 0; i < list.length; i++) {
                    var li = document.createElement('li');
                    li.style.padding = '2px';
                    li.style.textAlign = '-webkit-center';
                    var img = document.createElement('img');
                    img.style.borderRadius = '50%';
                    img.style.borderWidth = '2px';
                    img.style.borderColor = 'white';
                    img.style.borderStyle = 'solid';
                    img.style.padding = '0px';
                    //$(img).css('transition', '100ms linear');
                    $(img).css('object-fit', 'cover');
                    img.id = i;
                    img.setAttribute('type', 'artist');
                    img.alt = list[i].name + "@" + list[i].image + "@" + list[i].id;
                    //img.style.paddingBottom = '2px';
                    var year = document.createElement('label');
                    year.className = 'searchtext';
                    year.style.width = '100px';
                    year.style.fontSize = '9px';
                    year.style.paddingTop = '3px';
                    year.innerHTML = list[i].name;
                    //year.style.paddingTop = '3px';

                
                    var a = document.createElement('div');
                    a.style.display = 'inline-grid';
                    a.style.height = '100%';
                    img.setAttribute('type', 'artist');
                    img.id = i;
                    img.src = list[i].image.toString().replace('image.jpg', 'imagesmall.jpg');
                    img.style.display = 'inline';
                    img.width = '82';
                    img.height = '82';
                    img.style.padding = '2px';
                    li.appendChild(a);

                    var img_temp = document.createElement('img');
                    img_temp.src = list[i].image;

                    a.appendChild(img);
                    a.appendChild(year);
                    ul.appendChild(li);
                    ul_temp.appendChild(img_temp);
                }
                //document.getElementById('artistdiv').style.display = 'inline';
                $('img').on('error', function () {
                    $(this).attr('src', 'images/artist.png');
                });
                checkSelectedArtist();
            }
            fill_artists();
            fill_albums();
            fill_tracks();
        }
        
        function resetTimeout() {
            PageMethods.resetTimeout();
        }
        function TriggerPreviousSong() {
            PageMethods.getPreviousSong(OnSucceeded, OnFailed);
        }
        function getCookie(name) {
            var value = "; " + document.cookie;
            var parts = value.split("; " + name + "=");
            if (parts.length == 2) return parts.pop().split(";").shift();
        }
        function TriggerNextSong() {
            PageMethods.getNextSong(OnSucceeded, OnFailed);
        }
        function PlaySong() {
            setInterval(resetTimeout, 300000);
            PageMethods.getSongURL(OnSucceeded, OnFailed);
        }
        
        
        //aud.addEventListener("ended", clearMetadata)

        //aud.onended = function () {
        //    TriggerNextSong();
        //}; 
        function clearMetadata() {
            //navigator.mediaSession = null;
        }
        function OnSucceeded(response) {
            //clearMetadata();
            document.getElementById('listSongs').selectedIndex = 0;
            __doPostBack('<%= listSongs.UniqueID %>', '');
           
            if (response != "") {;
                //unfade(audio);
                PageMethods.getCurrentSongCover(setCover);
                PageMethods.getCurrentSongTitle(setTitle);
                PageMethods.getCurrentSongArtist(setArtist);
                PageMethods.getCurrentSongAlbum(setAlbum);
                try {
                    $(audiosource).attr('src', response);
                    audio.load();
                    checkNowplaying();
                    
                    audio.play();
                } catch(err) {
                    alert(err.message);
                }
                
            }
        }
        function updatemetadata() {
            var _title = '';
            var _album = '';
            var _artist = '';
            var _cover = '';
            for (var i = 0; i < __tracks__.length; i++) {
                if (__tracks__[i].id == __nowplayingid__) {
                    _title = __tracks__[i].name;
                    _album = __tracks__[i].album;
                    _artist = __tracks__[i].artist;
                    for (var j = 0; j < __albums__.length; j++) {
                        if (__albums__[j].id == __tracks__[i].album_id) {
                            _cover = __albums__[j].cover;
                            break;
                        }
                    }
                    break;
                }
            }
            if ('mediaSession' in navigator) {
                var data = new MediaMetadata({
                    title: _title,
                    artist: _artist,
                    album: _album,
                    artwork: [{ src: _cover.toString() }], 
                });
                navigator.mediaSession.metadata = data;

                navigator.mediaSession.setActionHandler('play', function () { 
                    audio.play();
                });
                navigator.mediaSession.setActionHandler('pause', function () { 
                    audio.pause();
                });
                navigator.mediaSession.setActionHandler('previoustrack', function () { 
                    if(RestartSong()) {
                        audio.currentTime = 0;
                    } else {
                        __previous__();
                    } 
                });
                navigator.mediaSession.setActionHandler('nexttrack', __next__);
            }
        }
        function fade(element) {
            var op = 1;  // initial opacity
            var timer = setInterval(function () {
                if (op <= 0.1) {
                    clearInterval(timer);
                }
                element.style.opacity = op;
                element.style.filter = 'alpha(opacity=' + op * 100 + ")";
                op -= op * 0.1;
            }, 50);
        }
        function unfade(element) {
            if(element.style.opacity == ''){
                var op = 0.1;  // initial opacity
                var timer = setInterval(function () {
                    if (op >= 1) {
                        clearInterval(timer);
                        element.style.opacity = 1;
                        //callback(element);
                    }
                    element.style.opacity = op;
                    element.style.filter = 'alpha(opacity=' + op * 100 + ")";
                    op += op * 0.1;
                }, 10);
            } else {
                if(parseInt(element.style.opacity) >= 1) {
                    var op = 0.1;  // initial opacity
                    var timer = setInterval(function () {
                        if (op >= 1) {
                            clearInterval(timer);
                            element.style.opacity = 1;
                            //callback(element);
                        }
                        element.style.opacity = op;
                        element.style.filter = 'alpha(opacity=' + op * 100 + ")";
                        op += op * 0.1;
                    }, 10);
                }
            }
        }
        function setCover(response) {
            var imgTop = document.getElementById('imgSongCoverTop');
            if (response) {
                imgTop.src = response.toString().replace("Cover.jpg", "CoverSmall.jpg");
            }
        }
        function setTitle(response) {
            //$('#topbar').slideDown();
            var lbl = document.getElementById('lblSongTitle');
            lbl.innerText = response;
            //unfade(lbl);
        }
        function setArtist(response) {
            var lbl = document.getElementById('lblSongArtist');
            lbl.innerText = response;
            //unfade(lbl);
        }
        function setAlbum(response) {
            var lbl = document.getElementById('lblSongAlbum');
                
            lbl.innerText = response;
            //unfade(lbl);
        }
        function OnFailed(error) {
            //alert('Error');
        }
        //newplayer
        
        
        $('#next').on('click', function () {
            var btn = document.getElementById('next');
            unfade(btn);
            __next__();
        });
        $('#previous').on('click', function () {
            var btn = document.getElementById('previous');
            unfade(btn);
            if(RestartSong()) {
                audio.currentTime = 0;
            } else {
                __previous__(); 
            }
        });
        $('#txtSearch').blur(function(){
            $('#txtSearch').css('padding', '12px');
            $('#txtSearch').css('width', '96%');
            $('#txtSearch').css('height', '30px');
        });
        $('#txtSearch').focus(function(){
            $('#txtSearch').css('padding', '15px');
            $('#txtSearch').css('width', '100%');
            $('#txtSearch').css('height', '40px');
        });
        //$(window).focus(function(){
        //    document.getElementById('audio').play();
        //});
        //var play = document.getElementById('play');
        $(audio).on('timeupdate', function () {
            try {
                if (audio.paused) {
                    $('#play').attr('src', 'images/play.png');
                } else {
                    $('#play').attr('src', 'images/pause.png');
                }
                $('#seekbar').attr("value", this.currentTime / this.duration);
                var date = new Date(null);
                date.setSeconds(this.currentTime); // specify value for SECONDS here

                var currentTime = date.toISOString().substr(14, 5);
                var date2 = new Date(null);
                date2.setSeconds(this.duration); // specify value for SECONDS here
                var duration = date2.toISOString().substr(14, 5);
                document.getElementById('currentTime').innerHTML = currentTime;
                document.getElementById('duration').innerHTML = duration;
                //updatemetadata();
            } catch (err) {

            }
            
        });
        var seekbar = document.getElementById('seekbar');
        seekbar.ondblclick = function (e) {
            var x = e.pageX - this.offsetLeft; // or e.offsetX (less support, though)
            x = x - parseInt($('#footer').css('left'));
            var y = e.pageY - this.offsetTop;  // or e.offsetY
            var clickedValue = (x * this.max / this.offsetWidth);
            var isClicked = clickedValue;
            if (isClicked) {
                var newtime = audio.duration * clickedValue;
                audio.currentTime = newtime;
            }
        };
        $('#play').on('click', function(e) {
            var pOffset = $(this).offset();
            var y = e.pageY - pOffset.top;

            if(y > 10) {
                var btn = document.getElementById('play');
                if ($(audiosource).attr('src') !== null)
                {
                    unfade(btn);
                    if (audio.paused) {
                        audio.play();
                        play.setAttribute('src', 'images/pause.png');
                    } else {
                        audio.pause();
                        play.setAttribute('src', 'images/play.png');
                    }
                }
            } else {
                
            }
        });
        //function getBase64Image(img) {
        //    // Create an empty canvas element
        //    var canvas = document.createElement("canvas");
        //    canvas.width = img.width;
        //    canvas.height = img.height;

        //    // Copy the image contents to the canvas
        //    var ctx = canvas.getContext("2d");
        //    ctx.drawImage(img, 0, 0);

        //    // Get the data-URL formatted image
        //    // Firefox supports PNG and JPEG. You could check img.src to
        //    // guess the original format, but be aware the using "image/jpg"
        //    // will re-encode the image.
        //    var dataURL = canvas.toDataURL("image/png");

        //    return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
        //}
        function Search(str) {
            $('#resultdiv').slideUp("fast", function () {
                var art = false;
                var alb = false;
                var trk = false;
                var list = document.getElementById('searchlist');
                list.innerHTML = '';
                if(__artists__.length > 0) {
                    
                    for (i = 0; i < __artists__.length; i++) {
                        if (__artists__[i].name.toLowerCase().indexOf(str.toLowerCase()) != -1) {
                            if (!art) {
                                var label = document.createElement('label');
                                label.className = 'searchtext';
                                label.innerText = 'Artistas';
                                label.style.fontSize = '10px';
                                label.style.color = '#83868b';
                                list.appendChild(label);
                            }
                            art = true;
                            var div = document.createElement('div');
                            var name = document.createElement('label');
                            name.className = 'searchtext';
                            name.innerHTML = __artists__[i].name;
                            //name.style.color = '#97A09B';
                            div.setAttribute('type', 'artist');
                            div.id = __artists__[i].id;
                            div.className = 'searchitem';
                            var img = document.createElement('img');
                            img.id = __artists__[i].id;
                            img.setAttribute('type', 'artist');
                            img.style.marginRight = '5px';
                            $(img).css('object-fit', 'cover');
                            $(img).css('border-radius', '50%');
                            //new
                            img.src = __artists__[i].image.replace('image.jpg', 'imagesmall.jpg');
                            //
                            
                            img.height = 30;
                            img.width = 30;
                            img.style.verticalAlign = 'middle';
                            div.appendChild(img);
                            div.appendChild(name);
                            list.appendChild(div);
                        }
                    }
                }
                            
                if (__albums__.length > 0) {
                    
                    for (i = 0; i < __albums__.length; i++) {
                        if (__albums__[i].name.toLowerCase().indexOf(str.toLowerCase()) != -1) {
                            if (!alb) {
                                var label = document.createElement('label');
                                label.className = 'searchtext';
                                label.innerText = 'Álbumes';
                                label.style.fontSize = '10px';
                                label.style.color = '#83868b';
                                list.appendChild(label);
                            }
                            alb = true;
                            var div = document.createElement('div');
                            var name = document.createElement('label');
                            var nameart = document.createElement('label');
                            name.className = 'searchtext';
                            nameart.className = 'searchtext';
                            name.innerHTML = __albums__[i].name;
                            nameart.innerHTML = " - " + __albums__[i].artist;
                            div.className = 'searchitem';
                            nameart.style.color = '#97A09B';
                            div.setAttribute('type', 'album');
                            div.id = __albums__[i].id;
                            var img = document.createElement('img');
                            img.id = __albums__[i].id;
                            img.setAttribute('type', 'album');
                            img.src = __albums__[i].cover.replace('Cover.jpg', 'CoverSmall.jpg');
                            img.style.marginRight = '5px';
                            img.height = 30;
                            img.width = 30;
                            img.style.verticalAlign = 'middle';
                            div.appendChild(img);
                            div.appendChild(name);
                            div.appendChild(nameart);
                            list.appendChild(div);
                        }
                    }
                }
                if(__tracks__.length > 0) {
                    
                    for (i = 0; i < __tracks__.length; i++) {
                        if (__tracks__[i].name.toLowerCase().indexOf(str.toLowerCase()) != -1) {
                            if (!trk) {
                                var label = document.createElement('label');
                                label.className = 'searchtext';
                                label.innerText = 'Canciones';
                                label.style.fontSize = '10px';
                                label.style.color = '#83868b';
                                list.appendChild(label);
                            }
                            trk = true;
                            var div = document.createElement('div');
                            var name = document.createElement('label');
                            var nameart = document.createElement('label');
                            var namealb = document.createElement('label');
                            namealb.className = 'searchtext';
                            namealb.style.color = '#97A09B';
                            namealb.innerHTML = " - " + __tracks__[i].album;
                            var br = document.createElement('br');
                            name.className = 'searchtext';
                            nameart.className = 'searchtext';
                            nameart.style.color = '#97A09B';
                            name.innerHTML = __tracks__[i].name;
                            nameart.innerHTML = __tracks__[i].artist;
                            div.setAttribute('type', 'track');
                            div.id = __tracks__[i].id;
                            div.className = 'searchitem';
                            var img = document.createElement('img');
                            img.id = __tracks__[i].id;
                            img.setAttribute('type', 'track');

                            var _album = getAlbum(__tracks__[i].album_id);
                            img.src = _album.cover.replace('Cover.jpg', 'CoverSmall.jpg');
                            img.style.marginRight = '5px';
                            img.height = 30;
                            img.width = 30;
                            img.style.verticalAlign = 'middle';
                            div.appendChild(img);
                            div.appendChild(name);
                            div.appendChild(namealb);
                            div.appendChild(br);
                            div.appendChild(nameart);
                            list.appendChild(div);
                        }
                    }
                }
                            
                if(art || alb || trk) {
                    $('#resultdiv').slideDown("fast");
                    $("#resultdiv").animate({ scrollTop: 0 }, 0);
                } else {
                    var label = document.createElement('label');
                    label.innerHTML = 'No hay resultados';
                    label.className = 'searchtext';
                    list.appendChild(label);
                    $('#resultdiv').slideDown("fast");
                }
            });
            return false;
        }
        
        function RestartSong() {
            
            if (audio.currentTime > 2) {
                return true;
            }
            return false;
        }
        function preventZoom(e) {
            var t2 = e.timeStamp;
            var t1 = e.currentTarget.dataset.lastTouch || t2;
            var dt = t2 - t1;
            var fingers = e.touches.length;
            e.currentTarget.dataset.lastTouch = t2;
            if (!dt || dt > 500 || fingers > 1)
                return;
            e.preventDefault();

            var clickEvent = document.createEvent('MouseEvents');
            clickEvent.initEvent('dblclick', true, true);
            e.target.dispatchEvent(clickEvent);
        }

        function preLoadCovers() {
            var c_list = document.getElementById('albumlist_temp');
            PageMethods.getAlbumImg(function (response) {
                var list = JSON.parse(response);
                for (i = 0; i < list.length; i++) {
                    var img = document.createElement('img');
                    img.src = list[i];
                    c_list.appendChild(img);
                }
                
            });
        };


        function fill_artists() {
            PageMethods.get_all_artists(function (response) {
                __artists__ = JSON.parse(response);
            });
        };
        function fill_albums() {
            PageMethods.get_all_albums(function (response) {
                __albums__ = JSON.parse(response);
            });
        };
        function fill_tracks() {
            PageMethods.get_all_tracks(function (response) {
                __tracks__ = JSON.parse(response);
            });
        };
        function __next__() {
            if (__nowplaying__ + 1 <= __queue__.split(';').length - 1) {
                var ids = __queue__.split(";");

                var id = parseInt(ids[__nowplaying__ + 1]);

                __nowplaying__ += 1;
                for (var i = 0; i < __tracks__.length; i++) {
                    if (__tracks__[i].id == id) {
                        __nowplayingid__ = __tracks__[i].id;
                        $(audiosource).attr('src', __tracks__[i].url);
                        setArtist(__tracks__[i].artist);
                        setAlbum(__tracks__[i].album);
                        setTitle(__tracks__[i].name);

                        var cover = "";
                        for (var j = 0; j < __albums__.length; j++) {
                            if (__albums__[j].id == __tracks__[i].album_id) {
                                cover = __albums__[j].cover;
                                break;
                            }
                        }
                        setCover(cover);
                        try {
                            audio.load();
                            audio.play().then(updatemetadata);
                            checkNowplaying();
                        } catch (err) {
                            __next__();
                        }
                        finally {
                            break;
                        }
                    }
                }
            } else {
                var list = __queue__.split(";");
                var altq = "";
                for (var i = 0; i < __tracks__.length; i++) {
                    if(!list.includes(__tracks__[i].id.toString())) {
                        altq += __tracks__[i].id + ";";
                    }
                }
                altq.substring(0, altq.length - 1);
                var r_altqlist = shuffleArray(altq.split(";"));
                r_altq = "";
                for (var i = 0; i < r_altqlist.length; i++) {
                    r_altq += r_altqlist[i] + ";";
                }
                r_altq = r_altq.substring(0, r_altq.length - 1);
                queueAddListEnd(r_altq);
                __next__();
            }
        };
        function __previous__() {
            if (__nowplaying__ - 1 >= 0) {
                var ids = __queue__.split(";");

                var id = parseInt(ids[__nowplaying__ - 1]);
                __nowplaying__ -= 1;
                for (var i = 0; i < __tracks__.length; i++) {
                    if (__tracks__[i].id == id) {
                        __nowplayingid__ = __tracks__[i].id;
                        $(audiosource).attr('src', __tracks__[i].url);
                        setArtist(__tracks__[i].artist);
                        setAlbum(__tracks__[i].album);
                        setTitle(__tracks__[i].name);

                        var cover = "";
                        for (var j = 0; j < __albums__.length; j++) {
                            if (__albums__[j].id == __tracks__[i].album_id) {
                                cover = __albums__[j].cover;
                                break;
                            }
                        }
                        setCover(cover);
                        audio.load();
                        audio.play().then(updatemetadata);
                        checkNowplaying();
                        break;
                    }
                }
            }
        };
    </script>
</body>

</html>
