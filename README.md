<!-- omit in toc -->
# PC-setup

The setup for various software on my PC, mainly related to programming. Intended for future self-reference as well as for any others that might stumble upon this.

<!-- omit in toc -->
## Table of Contents

- [General setup](#general-setup)
  - [Color scheme](#color-scheme)
  - [Editors](#editors)
  - [Font](#font)
- [Command line](#command-line)
  - [Shell](#shell)
  - [Terminal](#terminal)
  - [Tools](#tools)
- [RStudio](#rstudio)
- [VSCode](#vscode)
  - [Extensions](#extensions)

## General setup

### Color scheme

I quite like the [Catppuccin Mocha](https://catppuccin.com/palette) theme, and I use it for pretty much everything programming related. The Catppuccin themes have a (very) large number of [ports](https://catppuccin.com/ports), so a lot of your software can be customized with the same look.

### Editors

My main programming languages are Python and R. Besides this, I also often write Markdown and $\LaTeX$. My main editor is VSCode, which I use for most coding, writing,... It has great built-in features: git, refactoring, the scores of extensions, and so on. For R, I prefer RStudio, because of the easier access and management of variables and R-specific support. I also quite like to use the command line, but mainly for quickly running programs and doing various tasks, not the actual programming itself. My setups for this can be found in the following sections.

### Font

I use the [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) in everything programming-related. This font is not only very clear and nice to look at, it also provides ligatures, which I find quite helpful in coding. Opinions will definitely vary on this, but for me, someone with a background in mathematics, these ligatures make the text on the screen look the same as I would write them on paper. Besides ligatures, Nerd Fonts also provide a lot of symbols and icons, which are quite pretty and also provide useful information. For example, having the R programming language logo on screen is much clearer than just an uppercase R. There exist many Nerd Fonts besides FiraCode, so pick something that fits your taste. When installing a font on Windows, it is advisable to first go into properties and unblock the font, as not doing this might cause some issues.

## Command line

As mentioned above, I use the command line mainly to do some quick tasks and to run programs and the like, not for actual programming. For this I have some tools set up, which are detailed below.

### Shell

I use PowerShell (not to be confused with *Windows* PowerShell, which comes pre-installed on Windows but is no longer in development). PowerShell has to be [installed](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows) first. The easiest way to install things on Windows is by using [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/), the package manager for Windows. This should be installed by default on Windows 11 or modern versions of Windows 10. Installing PowerShell is then as simple as running

```bash
winget install --id Microsoft.PowerShell --source winget
```

PowerShell uses commands that are quite distinct from Unix commands, though helpfully a lot of aliases (`ls`,`cd`,`cat`,`cls`,...) are built-in right out of the box. You can get a list of all aliases by simply running `alias` in PowerShell.

To modify certain aspects of PowerShell, it is helpful to use the `$profile` file. Running `$profile` prints out the location of the file, and running e.g. `notepad $profile` or `code $profile` (VSCode) allows you to quickly open it up in an editor. This profile runs at start-up, so put all set-up and functions that you always want available in here. My `$profile` can be found [here](dotfiles/powershell/$profile.ps1). I set the autocomplete to list view with `Set-PSReadLineOption -PredictionViewStyle ListView`, as by default the autocomplete only shows one result. This can always be changed by pressing F2. Next, I provide some more Unix parity:

```powershell
function touch { $null > $args }
new-alias grep findstr
```

Details on the other setup can be found in the relevant sections.

### Terminal

To interact with a shell, you need a terminal. For this I use the built-in Windows Terminal. My setup is very basic, only changing the font to [FiraCode Nerd Font](#font) and the color scheme to [Catppuccin Mocha](https://github.com/catppuccin/windows-terminal).

### Tools

<!-- omit in toc -->
#### [`bat`](https://github.com/sharkdp/bat)

Installation:

```bash
winget install sharkdp.bat
```

`bat` is a replacement for the built-in `cat` command (`Get-Content` in PowerShell). `bat` features syntax highlighting, git integration and prettier output/formatting compared to `cat`. The `-d` or `--diff` flag allows for quick checking of the added/modified/removed lines in a file. The PowerShell code is similar to [`eza`](#eza): remove the alias and make new functions:

```powershell
# replace cat with bat
remove-item alias:cat
function cat { bat $args }
function catd { bat --diff $args }
```

I use the Catppuccin theme "Mocha", which can be found [here](https://github.com/catppuccin/bat). The installation instructions can be found there as well. My config file can be [here](dotfiles/bat/batconfig). I opt for the "full" style to also see file size and such.

> [!CAUTION]
> Rename `batconfig` to just `config` if you decide to download it.

---

<!-- omit in toc -->
#### [`cloc`](https://github.com/AlDanial/cloc)

Installation:

```bash
winget install aldanial.cloc
```

`cloc`, which stands for "**c**ount **l**ines **o**f **c**ode", does just that: it counts the lines of source code, and splits this up into blank lines, comments and actual code. Has options to exclude certain directories and/or file types. Can also count the difference between two versions of a project.

---

<!-- omit in toc -->
#### [`delta`](https://github.com/dandavison/delta)

Installation:

```bash
winget install dandavison.delta
```

`delta` is a syntax highlighter and pager for git, diff,... Requires [`bat`](#bat) and [`less`](#less) to function properly. As always, I use the [Catppuccin Mocha theme](https://github.com/catppuccin/delta). Allows for much better quick command line viewing of git commits, diffs,... through e.g. `git show` or `git diff`. Features line numbers, side-by-side, and also VSCode hyperlinks! Pretty neat thing. See also [my `.gitconfig`](dotfiles/git/.gitconfig) and the [theme file](dotfiles/delta/catppuccin.gitconfig).

---

<!-- omit in toc -->
#### [`eza`](https://github.com/eza-community/eza)

Installation:

```bash
winget install eza-community.eza
```

`eza` is a replacement for the built-in `ls` command (`Get-ChildItem` in PowerShell). `eza` features icons, git integration, colors, tree view and more. In my `$profile`, I remove the alias `ls`, and make two new functions: `ls` to replace the old `ls`, and `lst` as a short-hand for tree view:

```powershell
# replace ls with eza
remove-item alias:ls
function ls { eza --header --bytes --long --icons=always --git --classify=always --group-directories-first --no-time --no-permissions $args }
function lst { eza --header --bytes --long --icons=always --git --classify=always --group-directories-first --no-time --no-permissions --tree --level=2 $args }
$env:EZA_CONFIG_DIR = "$env:USERPROFILE\.config\eza"
```

The additional arguments are how I like them best, these can of course be changed. I use the [Catppuccin](dotfiles/eza/catppuccin.yml) theme.

> [!CAUTION]
> The filename needs to be `theme.yml`, otherwise the theme will not work. You will thus need to change the filename of the themes you find [here](https://github.com/eza-community/eza-themes).

---

<!-- omit in toc -->
#### [`fzf`](https://github.com/junegunn/fzf)

Installation:

```bash
winget install fzf
```

`fzf` is a fuzzy line finder to search for files, history, git commits,... Prefix with a single quote (`'`) for exact matching. Has great integration with [`bat`](#bat) through the command

```bash
fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
```

---

<!-- omit in toc -->
#### [`less`](https://github.com/jftuga/less-Windows)

Installation:

```bash
winget install jftuga.less
```

`less` is terminal pager. This allows one to view long files or output in a page-by-page manner, instead of just spamming the console full and having to scroll back manually. It also has handy built in features like search (`/` for forwards searching, `?` for backwards) and matching with `&`. Useful movement shortcuts are `g` for top of file, `G` for bottom, `f` for next page, `d` for next half page, `b` for previous page and `u` for previous half page.

[`bat`](#bat) automatically uses less by default when printing files.

---

<!-- omit in toc -->
#### [starship](https://starship.rs)

Installation:

```bash
winget install --id Starship.Starship
```

Starship is a customizable prompt supporting multiple shells. By default, PowerShell it not exactly the most appealing shell. By using Starship, it not only looks nicer, but also provides a lot of information at a glance, such as git status, execution time, (virtual) environment,... Configuration options are limitless. My config can be found [here](dotfiles/starship/starship.toml). The relevant `$profile` setup is the following:

```powershell
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship\starship.toml"
```

Where I moved the config file from the default location to its own folder. This config is largely an adaptation of [the nerd-font-symbols preset](https://starship.rs/presets/toml/nerd-font-symbols.toml). The main changes are to the color scheme (Catppuccin Mocha) and changing some default colors to the Mocha ones. I also changed the git integration a bit.

---

<!-- omit in toc -->
#### [yt-dlp](https://github.com/yt-dlp/yt-dlp)

Installation:

```bash
winget install yt-dlp
```

I have some functions for `yt-dlp` to more easily download from youtube. The function `dlp` downloads a song, extracts the audio, embeds the thumbnail and other metadata into the file (correcting the `year` to `release_year`). A second function `dlpl` is a shorthand for downloading playlists.

```powershell
# yt-dlp functions to download music from youtube
function dlp { yt-dlp --extract-audio --audio-format mp3 --audio-quality 128k --embed-thumbnail --embed-metadata --parse-metadata "%(release_year)s0823:%(upload_date)s" --output "%(title)s.%(ext)s" $args }
function dlpl { yt-dlp --extract-audio --audio-format mp3 --audio-quality 128k --embed-thumbnail --embed-metadata --parse-metadata "%(release_year)s0823:%(upload_date)s" --yes-playlist --output "%(title)s.%(ext)s" $args }
```

## RStudio

My RStudio setup is very simple, and a returning *theme*: [Catppuccin Mocha](https://github.com/catppuccin/rstudio) with the [FiraCode](https://github.com/tonsky/FiraCode) font. Both of these can be configured in the `Tools > Appearance` section. For some reason, the FiraCode *Nerd Font* doesn't work for me, but the regular one does. Personally, I only use RStudio to code, so the absence of icons has no impact on me.

## VSCode

As mentioned before, VSCode is my *daily driver* for coding, writing Markdown and $\LaTeX$. The setup is again the same: [FiraCode Nerd Font](#font) and Catppuccin Mocha. The font can be configured in `Settings > Editor: Font Family`. The Catppuccin Mocha theme can easily be installed by installing [the extension](https://marketplace.visualstudio.com/items?itemName=Catppuccin.catppuccin-vsc). There's also a separate [extension](https://marketplace.visualstudio.com/items?itemName=Catppuccin.catppuccin-vsc-icons) that provides custom icons. Besides this basic setup, I also use quite a number of other extensions. These are listed below.

### Extensions

<!-- omit in toc -->
#### [autoDocstring - Python Docstring Generator](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring)

Writing documentation is very important, and in Python I try to always write a detailed docstring in the [numpydoc](https://numpydoc.readthedocs.io/en/latest/format.html) style. This extension provides a handy snippet that can be tabbed through, with a summary, longer description, arguments, returns,... It supports other styles of docstring as well.

---

<!-- omit in toc -->
#### [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)

Handy extension to run code (supports quite a number of languages) with a single shortcut (Ctrl+Alt+N by default). If you just need to run a program without anything else, this is a pretty quick way to do it. For something more involved, I use the command line.

---

<!-- omit in toc -->
#### [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)

Spell checking. Only supports English (default US, UK available) by default, but has add-ons for other languages.

---

<!-- omit in toc -->
#### [Conventional Commits](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)

Conventional Commits is a standardization for commit messages, that makes a commit history uniform and also makes it easier to write automated tools.

---

<!-- omit in toc -->
#### [Data Wrangler](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.datawrangler)

Provides support for working with tabular data sets. If you work with pandas in Python (or something similar in another language), this is a nice way of viewing/checking/... your data set.

---

<!-- omit in toc -->
#### [Even Better TOML](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)

Support for TOML files, e.g. highlighting, validation, refactoring,...

---

<!-- omit in toc -->
#### [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter)

Extension pack for Jupyter support.

---

<!-- omit in toc -->
#### [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)

Support for $\LaTeX$ files. Features building, formatting, snippets... An all-round fantastic extension if you work with $\LaTeX$ quite a bit.

---

<!-- omit in toc -->
#### [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)

Markdown support, e.g. making lists, table of contents,...

---

<!-- omit in toc -->
#### [Markdown Preview Github Styling](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-preview-github-styles)

Provides a preview of your Markdown document rendered with GitHubs flavor.

---

<!-- omit in toc -->
#### [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

Linting for Markdown.

---

<!-- omit in toc -->
#### Python extensions

Several extensions provide Python support: [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance), [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python), [Python Debugger](https://marketplace.visualstudio.com/items?itemName=ms-python.debugpy) and [Python Docstring Highlighter](https://marketplace.visualstudio.com/items?itemName=rodolphebarbanneau.python-docstring-highlighter).

---

<!-- omit in toc -->
#### [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)

Makes CSV files a bit easier to read.

---

<!-- omit in toc -->
#### [Ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff)

Ruff is a linter and formatter for Python that replaces other tools like Black, isort, and flake8 and is also much faster than those tools to boot. Formatting is compatible with Black and isort.
