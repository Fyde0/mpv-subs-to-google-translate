local translate_from = "en"
local translate_to = "sv"

local last_sub = ""
-- observe subtitles and save latest in variable
mp.observe_property("sub-text", "string", function(name, value)
  if value then
    last_sub = value
  end
end)

-- open Google Translate in browser, change URL for language
function open_google_translate()
  if not last_sub or last_sub == "" then
    mp.osd_message("No subtitle to translate")
    return
  end
  
  -- build url
  local url = string.format(
    "https://translate.google.com/?sl=%s&tl=%s&text=%s&op=translate",
    translate_from, translate_to, last_sub
  )
  
  -- open browser
  mp.osd_message("Opening Google Translate...")
  os.execute(string.format('xdg-open "%s" &', url))

end

-- key binding
mp.add_key_binding("Ctrl+t", "translate_subtitle", open_google_translate)
