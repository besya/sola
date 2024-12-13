local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config = {
    keys = {
        {
            key = "k",
            mods = "CMD",
            action = wezterm.action.ClearScrollback("ScrollbackAndViewport")
        },
    },
    default_cursor_style = "SteadyBar",
    automatically_reload_config = true,
    window_close_confirmation = "NeverPrompt",
    adjust_window_size_when_changing_font_size = false,
    window_decorations = "RESIZE",
    check_for_updates = false,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = false,
    font_size = 12,
    font = wezterm.font("JetBrains Mono", { weight = "Medium", stretch = "Normal", style = "Normal" }), -- <built-in>, BuiltIn
    enable_tab_bar = false,
    window_padding = {
        left = 20,
        right = 20,
        top = 20,
        bottom = 20,
    },
    background = {
        {
            source = {
                File = "/Users/" .. os.getenv("USER") .. "/.config/wezterm/bg-monterey.png",
            },
            hsb = {
                hue = 1.0,
                saturation = 1.02,
                brightness = 0.10,
            },
            -- attachment = { Parallax = 0.3 },
            -- width = "100%",
            -- height = "100%",
        },
        {
            source = {
                Color = "#282c35",
            },
            width = "100%",
            height = "100%",
            opacity = 0.55,
        },
    },
    -- from: https://akos.ma/blog/adopting-wezterm/
    hyperlink_rules = {
        -- Matches: a URL in parens: (URL)
        {
            regex = "\\((\\w+://\\S+)\\)",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in brackets: [URL]
        {
            regex = "\\[(\\w+://\\S+)\\]",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in curly braces: {URL}
        {
            regex = "\\{(\\w+://\\S+)\\}",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in angle brackets: <URL>
        {
            regex = "<(\\w+://\\S+)>",
            format = "$1",
            highlight = 1,
        },
        -- Then handle URLs not wrapped in brackets
        {
            -- Before
            --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
            --format = '$0',
            -- After
            regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
            format = "$1",
            highlight = 1,
        },
        -- implicit mailto link
        {
            regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
            format = "mailto:$0",
        },
    },
}
return config
