# Nushell Environment Config File
#
# version = "0.85.0"

def create_left_prompt [] {
    let dir_list = (
        $env.PWD 
        | str replace $nu.home-path "~" 
        | path split 
        | if ($in | get 0) == "/" { $in | update 0 "" } else { $in }
    )
    let dir_list_len = $dir_list | length

    let dir = (
        if $dir_list_len < 3 {
            $dir_list
        } else {
            [
                ($dir_list | get 0),
                ($dir_list | range 1..<-1 | each { |it| $"($it | str substring 0..1)… " } ),
                ($dir_list | get ($dir_list_len - 1))
            ] | flatten
        }
    ) | str join "/"

    let hostname = (
        ^hostname 
        | if $in == "localhost" {
            "local" 
        } else if ( ($in | str length) > 8) {
            $"($in | str substring 0..7)… "
        } else { $in }
    )

    let has_error = $env.LAST_EXIT_CODE != 0
    let last_exit_code = if $has_error {
        $env.LAST_EXIT_CODE | into string
    } else { "" }

    let dt = date now | format date "%Y-%m-%d %H:%M:%S"

    let color_user_fg  = "#1C68A6"
    let color_userinfo_bg = '#000000'
    let color_host_fg = '#FFFFFF'
    let color_dirinfo_fg = '#FFFFFF'
    let color_dirinfo_bg = '#1C68A6'
    let color_exit_bg = if $has_error { "#A33662" } else { "#6CA336" }
    let color_exit_fg = "#FFFFFF"
    let color_time_bg = "#000000"
    let color_time_fg = "#FFFFFF"

    [
        (ansi {fg: $color_user_fg, bg: $color_userinfo_bg, attr: "b"}),
        $" (^whoami)",
        (ansi reset),
        #
        (ansi {fg: $color_host_fg, bg: $color_userinfo_bg, attr: "d"}),
        $"@($hostname) ",
        (ansi reset),
        #
        (ansi {fg: $color_userinfo_bg, bg: $color_dirinfo_bg}),
        "",
        # (ansi reset),
        #
        (ansi {fg: $color_dirinfo_fg, bg: $color_dirinfo_bg}),
        $" ($dir) ",
        # (ansi reset),
        #
        (ansi {fg: $color_dirinfo_bg, bg: $color_exit_bg}),
        "",
        # (ansi reset)
        #
        (ansi {fg: $color_exit_fg, bg: $color_exit_bg}),
        (if $has_error { $"✘ ($env.LAST_EXIT_CODE) " } else { "✔ " } ),
        # (ansi reset)
        #
        (ansi {fg: $color_exit_bg, bg: $color_time_bg}),
        "",
        # (ansi reset),
        #
        (ansi {fg: $color_time_fg, bg: $color_time_bg, attr: "d"}),
        $" ($dt) ",
        (ansi reset),
        #
        (ansi {fg: $color_time_bg, bg: "default"}),
        "",
        (ansi reset),
    ] | str join
}

# The left prompt
$env.PROMPT_COMMAND = { || $"(create_left_prompt)\n\n" }

$env.PROMPT_COMMAND_RIGHT = {|| ""}

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| " ❯ " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| " +❯" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "vi❯ " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::::::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    # FIXME: This default is not implemented in rust code as of 2023-09-06.
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    # FIXME: This default is not implemented in rust code as of 2023-09-06.
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
