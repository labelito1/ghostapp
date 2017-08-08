﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using migh.api;
using System.Web.Services;
using System.Net;
using JsonTools;
using System.Web.Script.Serialization;

namespace migh.application
{
    public partial class Default : System.Web.UI.Page
    {
        static Library lib = null;
        User user = new User();

        #region load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Add("user", null);
                string download = Request.QueryString["download"];
                string nowplaying = Request.QueryString["nowplaying"];
                string session = Request.QueryString["session"];
                try
                {
                    //if (session != null)
                    //{
                    //    if (session.ToLower() == "end")
                    //    {
                    //        Session.Clear();
                    //    }
                    //}
                    //else
                    //{
                    //    if (download != null)
                    //    {
                    //        if (download.ToLower() == "nowplaying")
                    //        {
                    //            if (Session["currentList"] != null)
                    //            {
                    //                List<Song> list = Session["currentList"] as List<Song>;
                    //                int index = (int)Session["currentSongIndex"];
                    //                Song song = list.ElementAt(index);
                    //                Artist artist = Artist.get(lib.artist_list, song.artist_id);
                    //                Album album = Album.get(lib.album_list, song.album_id);
                    //                string url = string.Format(lib.configuration.AudioFileURLFormat, artist.url_name, album.url_name, Tools.ConvertToGitHubFile(song.file_name, lib.configuration.GitHubFile_TextToReplace_List));
                    //                Response.Redirect(url);
                    //            }
                    //        }
                    //        else
                    //        {
                    //            int SongID = Convert.ToInt32(download);
                    //            if (Song.id_exists(lib.song_list, SongID))
                    //            {
                    //                Song song = lib.song_list.Single(n => n.id == SongID);
                    //                Artist artist = Artist.get(lib.artist_list, song.artist_id);
                    //                Album album = Album.get(lib.album_list, song.album_id);
                    //                string url = string.Format(lib.configuration.AudioFileURLFormat, artist.url_name, album.url_name, Tools.ConvertToGitHubFile(song.file_name, lib.configuration.GitHubFile_TextToReplace_List));
                    //                Response.Redirect(url);
                    //            }
                    //        }
                    //    }
                    //    else
                    //    {
                    //        if (nowplaying != null)
                    //        {
                    //            int SongID = Convert.ToInt32(nowplaying);
                    //            if (Song.id_exists(lib.song_list, SongID))
                    //            {
                    //                Song song = lib.song_list.Single(n => n.id == SongID);
                    //                List<Song> list = new List<Song>();
                    //                list.Add(song);
                    //                Session["currentList"] = list;
                    //                Session["currentSongIndex"] = 0;
                    //                Session["selectedSong"] = SongID;
                    //                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "PlaySong();", true);
                    //            }
                    //        }
                    //    }
                    //}
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "cleansomee()", true);
                }
                catch { }
            }
            Session.Timeout = 300;
            int t = Session.Timeout;
            try
            {
                if (Session["user"] == null || lib.artist_list.Count == 0)
                {
                    string su = "ftp://ftp.drivehq.com/migh.lib";
                    string su_alt = System.Configuration.ConfigurationManager.AppSettings["libsource"];
                    string u = "505darksoft2";
                    string p = "poder123";

                    lib = new Library(su, u, p);

                    string username = "Dark";
                    try
                    {
                        user = lib.user_list.Single(us => us.name.ToLower() == username.ToLower());
                    }
                    catch
                    {
                        lib = new Library(su_alt, u, p);
                        user = lib.user_list.Single(us => us.name.ToLower() == username.ToLower());
                    }
                    
                    Session.Add("user", user);
                    listArtists.SelectedIndex = 0;
                }
                user = Session["user"] as User;
                ListItem def = new ListItem();
                def.Text = "(Artista)";
                if(!listArtists.Items.Contains(def))
                {
                    listArtists.Items.Add(def);
                }
                
                List<Artist> SortedList = lib.artist_list.OrderBy(o => o.name).ToList();
                foreach(Artist art in SortedList)
                {
                    ListItem item = new ListItem();
                    item.Text = art.name;
                    item.Value = art.id.ToString();
                    if (!listArtists.Items.Contains(item))
                    {
                        listArtists.Items.Add(item);
                    }
                }
                //foreach (int i in user.artist_list)
                //{
                //    Artist artist = Artist.get(lib.artist_list, i);
                //    ListItem item = new ListItem();
                //    item.Text = artist.name;
                //    item.Value = artist.id.ToString();
                //    if (!listArtists.Items.Contains(item))
                //    {
                //        listArtists.Items.Add(item);
                //    }
                //}
                
            }
            catch (Exception ex)
            {
                Response.Write("<script> alert('" + ex.Message + "')</script>");
            }
        }
        #endregion

        #region canción actual
        [WebMethod]
        public static string setCurrentSong()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    Artist artist = Artist.get(lib.artist_list, song.artist_id);
                    Album album = Album.get(lib.album_list, song.album_id);
                    res = string.Format(lib.configuration.AudioFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(album.name), Song.getFileFormat(song));
                }
            }
            return res;
        }
        #endregion

        #region url canción seleccionada
        [WebMethod]
        public static string getSongURL()
        {
            string url = "";
            if (HttpContext.Current.Session["selectedSong"] != null)
            {
                int id = Convert.ToInt32(HttpContext.Current.Session["selectedSong"]);

                foreach (Song song in lib.song_list)
                {
                    if (song.id == id)
                    {
                        Album album = Album.get(lib.album_list, song.album_id);
                        Artist artist = Artist.get(lib.artist_list, song.artist_id);
                        url = string.Format(lib.configuration.AudioFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(album.name), Song.getFileFormat(song));
                        return url;
                    }
                }
            }
            return url;
        }
        #endregion

        #region información de canción actual
        [WebMethod]
        public static string getCurrentSongCover()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    Artist artist = Artist.get(lib.artist_list, song.artist_id);
                    Album album = Album.get(lib.album_list, song.album_id);
                    res = string.Format(lib.configuration.AlbumCoverImageFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(album.name));
                }
            }
            return res;
        }
        
        [WebMethod]
        public static string getCurrentSongTitle()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    res = song.name;
                }
            }
            return res;
        }
        
        [WebMethod]
        public static string getCurrentSongArtist()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    Artist artist = Artist.get(lib.artist_list, song.artist_id);
                    res = song.JoinedPerformers.Replace(';', ',');
                }
            }
            return res;
        }
        [WebMethod]
        public static string getCurrentSongAlbum()
        {
            string res = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    Song song = songs.ElementAt(index);
                    Album album = Album.get(lib.album_list, song.album_id);
                    res = album.name;
                }
            }
            return res;
        }
        #endregion

        #region set timeout
        [WebMethod]
        public static void resetTimeout()
        {
            HttpContext.Current.Session.Timeout = 300;
        }
        #endregion
        [WebMethod]
        public static void setCookie(string id)
        {
            setNowplaying(Convert.ToInt32(id));
        }
        public static void setNowplaying(int id)
        {
            HttpCookie nowplaying = new HttpCookie("nowplaying");
            nowplaying.Value = id.ToString();
            HttpContext.Current.Response.Cookies.Clear();
            HttpContext.Current.Response.Cookies.Add(nowplaying);
        }
        #region canción siguiente
        [WebMethod]
        public static string getNextSong()
        {
            HttpContext.Current.Session.Timeout = 300;
            string url = "";
            if(HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if(HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    if(index < songs.Count-1)
                    {
                        HttpContext.Current.Session["currentSongIndex"] = index + 1;
                        Song nextSong = songs.ElementAt(index + 1);
                        Artist artist = Artist.get(lib.artist_list, nextSong.artist_id);
                        Album album = Album.get(lib.album_list, nextSong.album_id);
                        url = string.Format(lib.configuration.AudioFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(album.name), Song.getFileFormat(nextSong));
                        setNowplaying(nextSong.id);
                        return url;
                    }
                }
            }
            return url;
        }
        #endregion

        #region canción anterior
        [WebMethod]
        public static string getPreviousSong()
        {
            string url = "";
            if (HttpContext.Current.Session["currentList"] != null)
            {
                List<Song> songs = HttpContext.Current.Session["currentList"] as List<Song>;
                if (HttpContext.Current.Session["currentSongIndex"] != null)
                {
                    int index = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                    if (index > 0)
                    {
                        HttpContext.Current.Session["currentSongIndex"] = index - 1;
                        Song previousSong = songs.ElementAt(index - 1);
                        Artist artist = Artist.get(lib.artist_list, previousSong.artist_id);
                        Album album = Album.get(lib.album_list, previousSong.album_id);
                        url = string.Format(lib.configuration.AudioFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(album.name), Song.getFileFormat(previousSong));
                        setNowplaying(previousSong.id);
                        return url;
                    }
                }
            }
            return url;
        }
        #endregion

        #region eventos combos
        protected void listArtists_SelectedIndexChanged(object sender, EventArgs e)
        {
            string artistname = "";
            List<ListItem> list = new List<ListItem>();
            if(listArtists.SelectedIndex > 0)
            {
                listAlbums.Items.Clear();
                listAlbums.Items.Add("(Álbum)");
                listSongs.Items.Clear();
                listSongs.Items.Add("(Canción)");
                Artist artist = Artist.get(lib.artist_list, Convert.ToInt32(listArtists.SelectedValue));
                IEnumerable<Album> tempList = lib.album_list.Where(a => a.artist_id == artist.id);
                IEnumerable<Album> sortedList = tempList.OrderByDescending(o => o.year);
                if (artist != null)
                {
                    List<string> albumimg = new List<string>();
                    List<string> albumname = new List<string>();
                    List<string> year = new List<string>();
                    List<int> id = new List<int>();
                    
                    foreach(Album album in sortedList)
                    {
                        if(album.artist_id == artist.id)
                        {
                            albumimg.Add(string.Format(lib.configuration.AlbumCoverImageFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(album.name)));
                            albumname.Add(album.name);
                            year.Add(album.year.ToString());
                            id.Add(album.id);
                            artistname = artist.name;
                            ListItem item = new ListItem();
                            item.Text = album.name;
                            item.Value = album.id.ToString();
                            listAlbums.Items.Add(item);

                        }
                    }
                    listAlbums.SelectedIndex = 0;
                    listSongs.SelectedIndex = 0;
                    var albumnames = Newtonsoft.Json.JsonConvert.SerializeObject(albumname.ToArray<string>());
                    var aname = Newtonsoft.Json.JsonConvert.SerializeObject(artistname);
                    var acovers = Newtonsoft.Json.JsonConvert.SerializeObject(albumimg.ToArray<string>());
                    var ids = Newtonsoft.Json.JsonConvert.SerializeObject(id.ToArray<int>());
                    var years = Newtonsoft.Json.JsonConvert.SerializeObject(year.ToArray<string>());
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "fillCovers(" + acovers + "," + albumnames + "," + aname + "," + ids + "," + years + ")", true);
                }
            }
            else
            {
                //listAlbums.Items.Clear();
                //listAlbums.Items.Add("(Álbum)");
                //listSongs.Items.Clear();
                //listSongs.Items.Add("(Canción)");
                //foreach(Album album in lib.album_list)
                //{
                //    ListItem item = new ListItem();
                //    item.Text = album.name;
                //    item.Value = album.id.ToString();
                //    listAlbums.Items.Add(item);
                //}
                //foreach (Song song in lib.song_list)
                //{
                //    ListItem item = new ListItem();
                //    item.Text = song.name;
                //    item.Value = song.id.ToString();
                //    listSongs.Items.Add(item);
                //}
            }
            UpdatePanel1.Update();
        }

        protected void listAlbums_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listAlbums.SelectedIndex > 0)
            {
                listSongs.Items.Clear();
                listSongs.Items.Add("(Canción)");
                Album album = Album.get(lib.album_list, Convert.ToInt32(listAlbums.SelectedValue));
                List<string> tracks = new List<string>();
                List<int> ids = new List<int>();
                List<string> duration = new List<string>();
                List<int> tracknumber = new List<int>();
                IEnumerable<Song> tempList = lib.song_list.Where(a => a.album_id == album.id);
                IEnumerable<Song> sortedList = tempList.OrderBy(o => o.Track);

                int tracki = 1;
                if (album != null)
                {
                    foreach (Song song in sortedList)
                    {
                        if (song.album_id == album.id)
                        {
                            ListItem item = new ListItem();
                            item.Text = song.name;
                            item.Value = song.id.ToString();
                            tracks.Add(song.name);
                            ids.Add(song.id);
                            duration.Add(song.duration.ToString("mm\\:ss"));
                            tracknumber.Add(Convert.ToInt32(song.Track));
                            if (!listSongs.Items.Contains(item))
                            {
                                listSongs.Items.Add(item);
                            }
                            tracki++;
                        }
                    }
                    listSongs.SelectedIndex = 0;
                    var tracklist = Newtonsoft.Json.JsonConvert.SerializeObject(tracks.ToArray<string>());
                    var idlist = Newtonsoft.Json.JsonConvert.SerializeObject(ids.ToArray<int>());
                    var durations = Newtonsoft.Json.JsonConvert.SerializeObject(duration.ToArray<string>());
                    var tracknumbers = Newtonsoft.Json.JsonConvert.SerializeObject(tracknumber.ToArray<int>());

                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "playTrack(" + tracklist + "," + idlist + "," + durations + "," + tracknumbers + ")", true);
                }
            }
            else
            {
                try
                {
                    Album album = Album.get(lib.album_list, Convert.ToInt32(listAlbums.SelectedValue));
                    Artist artist = Artist.get(lib.artist_list, album.artist_id);
                    listSongs.Items.Clear();
                    listSongs.Items.Add("(Canción)");
                    foreach (Song song in lib.song_list)
                    {
                        if (song.artist_id == artist.id)
                        {
                            ListItem item = new ListItem();
                            item.Text = song.name;
                            item.Value = song.id.ToString();
                            listSongs.Items.Add(item);
                        }
                    }
                }
                catch { }
                
            }
        }

        protected void listSongs_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listSongs.SelectedIndex > 0)
            {
                List<Song> songs = new List<Song>();
                int index = listSongs.SelectedIndex -1;
                for (int i = 1; i < listSongs.Items.Count; i++)
                {
                    ListItem item = listSongs.Items[i] as ListItem;
                    foreach (Song song in lib.song_list)
                    {
                        if (song.id == Convert.ToInt32(item.Value))
                        {
                            songs.Add(song);
                            break;
                        }
                    }
                }

                Session.Add("currentList", songs);
                Session.Add("currentSongIndex", index);
                Session.Add("selectedSong", Convert.ToInt32(listSongs.SelectedValue));
                try
                {
                    List<Song> songlist = HttpContext.Current.Session["currentList"] as List<Song>;
                    if (HttpContext.Current.Session["currentSongIndex"] != null)
                    {
                        int nowplayingindex = Convert.ToInt32(HttpContext.Current.Session["currentSongIndex"]);
                        Song currentsong = songs.ElementAt(nowplayingindex);
                        setNowplaying(currentsong.id);
                    }
                }
                catch { }

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "PlaySong()", true);
            }
        }
        #endregion
        
        #region SEARCH
        struct strArtist
        {
            public int id { get; set; }
            public string name { get; set; }
        }
        struct strAlbum
        {
            public int id { get; set; }
            public string name { get; set; }
            public string artist { get; set; }
            public string cover { get; set; }
        }
        struct strTrack
        {
            public int id { get; set; }
            public string name { get; set; }
            public string artist { get; set; }
            public string album { get; set; }
        }
        [WebMethod]
        public static string SearchArtist(string name)
        {
            IEnumerable<Artist> l = lib.artist_list.Where(a => a.name.ToLower().Contains(name.ToString().ToLower()));
            List<strArtist> list = new List<strArtist>();
            foreach(Artist art in l)
            {
                //if(art.name.ToLower().Contains(name.ToString().ToLower()))
                //{
                    strArtist a = new strArtist();
                    a.id = art.id;
                    a.name = art.name;
                    list.Add(a);
                //}
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(list.ToArray<strArtist>());
        }
        [WebMethod]
        public static string SearchAlbum(string name)
        {
            IEnumerable<Album> l = lib.album_list.Where(a => a.name.ToLower().Contains(name.ToString().ToLower()));
            List<strAlbum> list = new List<strAlbum>();
            foreach (Album alb in l)
            {
                //if (alb.name.ToLower().Contains(name.ToString().ToLower()))
                //{
                    Artist art = Artist.get(lib.artist_list, alb.artist_id);
                    strAlbum a = new strAlbum();
                    a.id = alb.id;
                    a.name = alb.name;
                    a.artist = art.name;
                    a.cover = string.Format(lib.configuration.AlbumCoverImageFileURLFormat,  Tools.ConvertToGitHubFolder(art.name), Tools.ConvertToGitHubFolder(alb.name));
                    list.Add(a);
                //}
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(list.ToArray<strAlbum>());
        }
        [WebMethod]
        public static string SearchTrack(string name)
        {
            IEnumerable<Song> l = lib.song_list.Where(a => a.name.ToLower().Contains(name.ToString().ToLower()));
            List<strTrack> list = new List<strTrack>();
            foreach (Song song in l)
            {
                //if (song.name.ToLower().Contains(name.ToString().ToLower()))
                //{
                    Artist art = Artist.get(lib.artist_list, song.artist_id);
                    Album alb = Album.get(lib.album_list, song.album_id);
                    strTrack a = new strTrack();
                    a.id = song.id;
                    a.name = song.name;
                    a.artist = art.name;
                    a.album = alb.name;
                    list.Add(a);
                //}
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(list.ToArray<strTrack>());
        }
        struct strPlayTrack
        {
            public string name { get; set; }
            public string album { get; set; }
            public string artist { get; set; }
            public string JoinedPerformers { get; set; }
            public string cover { get; set; }
            public string url { get; set; }
        }
        [WebMethod]
        public static string GetTrack(string id)
        {
            strPlayTrack str = new strPlayTrack();
            Song song = lib.song_list.First(s => s.id == Convert.ToInt32(id));
            Artist artist = Artist.get(lib.artist_list, song.artist_id);
            Album album = Album.get(lib.album_list, song.album_id);
            string url = string.Format(lib.configuration.AudioFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(album.name), Song.getFileFormat(song));
            string cover = string.Format(lib.configuration.AlbumCoverImageFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(album.name));
            str.JoinedPerformers = song.JoinedPerformers.Replace(';', ',');

            str.name = song.name;
            str.album = album.name;
            str.artist = artist.name;
            str.cover = cover;
            str.url = url;
            return Newtonsoft.Json.JsonConvert.SerializeObject(str);
        }
        [WebMethod]
        public static string GetAlbum(string id)
        {
            List<strAlbum> album = new List<strAlbum>();
            Artist artist = Artist.get(lib.artist_list, Convert.ToInt32(Convert.ToInt32(id)));

            if (artist != null)
            {
                List<string> albumimg = new List<string>();
                List<string> albumname = new List<string>();
                foreach (Album a in lib.album_list)
                {
                    if (a.artist_id == artist.id)
                    {
                        strAlbum s = new strAlbum();
                        s.id = a.id;
                        s.name = a.name;
                        s.artist = artist.name;
                        s.cover = string.Format(lib.configuration.AlbumCoverImageFileURLFormat, Tools.ConvertToGitHubFolder(artist.name), Tools.ConvertToGitHubFolder(a.name));
                        album.Add(s);
                    }

                }
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(album);
                    
        }
        [WebMethod]
        public static string GetAlbumTracks(string id)
        {
            List<Song> list = new List<Song>();
            foreach(Song s in lib.song_list)
            {
                if(s.album_id == Convert.ToInt32(id))
                {
                    list.Add(s);
                }
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(list.ToArray<Song>());
        }
        [WebMethod]
        public static int getArtistByAlbumId(int album_id)
        {
            Album album = lib.album_list.FirstOrDefault(a => a.id == album_id);
            Artist artist = lib.artist_list.FirstOrDefault(a => a.id == album.artist_id);
            return artist.id;
        }
        [WebMethod]
        public static int getAlbumBySongId(int song_id)
        {
            Song song = lib.song_list.FirstOrDefault(a => a.id == song_id);
            Album album = lib.album_list.FirstOrDefault(a => a.id == song.album_id);
            return album.id;
        }
        [WebMethod]
        public static int getArtistBySongId(int song_id)
        {
            Song song = lib.song_list.FirstOrDefault(a => a.id == song_id);
            Artist artist = lib.artist_list.FirstOrDefault(a => a.id == song.artist_id);
            return artist.id;
        }
        #endregion
    }
}