# I find this nicer, can switch with F2
Set-PSReadLineOption -PredictionViewStyle ListView

# for some reason not built-in
function touch { $null > $args }
new-alias grep findstr

# replace cat with bat
remove-item alias:cat
function cat { bat $args }
function catd { bat --diff $args }

# replace ls with eza
remove-item alias:ls
function ls { eza --header --bytes --long --icons=always --git --classify=always --group-directories-first --no-time --no-permissions $args }
function lst { eza --header --bytes --long --icons=always --git --classify=always --group-directories-first --no-time --no-permissions --tree --level=2 $args }
$env:EZA_CONFIG_DIR = "$env:USERPROFILE\.config\eza"

# starship setup
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship\starship.toml"

# yt-dlp functions to download music from youtube
function dlp { yt-dlp --extract-audio --audio-format mp3 --audio-quality 128k --embed-thumbnail --embed-metadata --parse-metadata "%(release_year)s0823:%(upload_date)s" --output "%(title)s.%(ext)s" $args }
function dlpl { yt-dlp --extract-audio --audio-format mp3 --audio-quality 128k --embed-thumbnail --embed-metadata --parse-metadata "%(release_year)s0823:%(upload_date)s" --yes-playlist --output "%(title)s.%(ext)s" $args }
