
//////////////////////////////////////////
// webjumps

// define_webjump("g", "http://www.google.com/search?q=%s");

webjumps.g = webjumps.google;
delete webjumps.google;
webjumps.w = webjumps.wikipedia;
delete webjumps.wikipedia;

define_webjump("gi", "http://www.google.com/images?q=%s&safe=off", $alternative = "http://www.google.com/imghp?as_q=&safe=off");

define_webjump("rae", "http://lema.rae.es/drae/srv/search?type=3&val=%s&val_aux=casa&origen=RAE");
define_webjump("ie", "http://www.wordreference.com/enit/translation.asp?enit=%s&dict=enes&b=Search");
define_webjump("ei", "http://www.wordreference.com/enit/translation.asp?enit=%s&dict=esen&b=Search");
define_webjump("ep", "http://www.wordreference.com/enit/translation.asp?enit=%s&dict=espt&b=Search");
define_webjump("pe", "http://www.wordreference.com/enit/translation.asp?enit=%s&dict=ptes&b=Search");
define_webjump("idef", "http://www.wordreference.com/enit/translation.asp?enit=%s&dict=enen&b=Search");
define_webjump("def", "http://www.wordreference.com/enit/translation.asp?enit=%s&dict=eses&b=Search");

define_webjump("w", "http://en.wikipedia.org/wiki/Special:Search?search=%s");
define_webjump("y", "http://www.youtube.com/results?search_query=%s&search_type=&aq=f");

//////////////////////////////////////////
// SESSION MANAGEMENT AND AUTO-SAVE SESSIONS

require("session.js");
session_auto_save_auto_load = true;

//////////////////////////////////////////
// RECOVER CLOSED BUFFERS

// I think by the time kill_buffer_hook runs the buffer is gone so I
// patch kill_buffer

var kill_buffer_original = kill_buffer_original || kill_buffer;

var killed_buffer_urls = [];

kill_buffer = function (buffer, force) {
    if (buffer.display_uri_string) {
        killed_buffer_urls.push(buffer.display_uri_string);
    }

    kill_buffer_original(buffer,force);
};

interactive("restore-killed-buffer-url", "Loads url from a previously killed buffer",
            function restore_killed_buffer_url (I) {
                if (killed_buffer_urls.length !== 0) {                
                    var url = yield I.minibuffer.read(
						$prompt = "Restore killed url:",
						$completer = all_word_completer($completions = killed_buffer_urls),
                        $default_completion = killed_buffer_urls[killed_buffer_urls.length - 1],
                        $auto_complete = "url",
                        $auto_complete_initial = true,
                        $auto_complete_delay = 0,
                        $match_required);
                    
                    load_url_in_new_buffer(url);
                } else {
                    I.window.minibuffer.message("No killed buffer urls");
                }
            });


//////////////////////////////////////////
// BIG HINT NUMBERS
register_user_stylesheet(
    "data:text/css," +
        escape(
            "@namespace url(\"http://www.w3.org/1999/xhtml\");\n" +
            "span.__conkeror_hint {\n"+
            "  font-size: 18px !important;\n"+
            "  line-height: 18px !important;\n"+
            "}"));


////////// MOUSE

// Open Middle-Clicked Links in New Buffers
require("clicks-in-new-buffer.js");

// Set to either OPEN_NEW_BUFFER or OPEN_NEW_BUFFER_BACKGROUND
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND; // Now buffers open in background.

// Set to 0 = left mouse, 1 = middle mouse, 2 = right mouse
clicks_in_new_buffer_button = 1;

//////////////////////////////////////////
// TESTING

// Javascript console 
// function jsconsole(args)
// {
//    var prefix = args[0];
//    open_url_in (prefix, "chrome://global/content/console.xul");
// }
// add_command("jsconsole", jsconsole, [["p"]]);

// let (home = get_home_directory()) {
//     home.append("html/intex.html");
//     homepage = home.path;
// }


// function my_title_format (window) {
//    return 'conkeror {'+get_current_profile()+'}'+window.buffers.current.description;
// }

//////////////////////////////////////////
// KEY MAPPINGS

define_key(content_buffer_normal_keymap, "C-z", "restore-killed-buffer-url");

define_key(content_buffer_normal_keymap, "f", "follow-new-buffer-background");
define_key(content_buffer_normal_keymap, "C-f", "follow");
// define_key(content_buffer_normal_keymap, "C-f", "follow-new-buffer");
define_key(content_buffer_normal_keymap, "M-f", "follow-new-window");

define_key(content_buffer_normal_keymap, "g", "find-url-new-buffer");
define_key(content_buffer_normal_keymap, "C-g", "find-url");
define_key(content_buffer_normal_keymap, "M-g", "find-url-new-window");
