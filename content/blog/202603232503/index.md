+++
title = "Pairing Tmux and Kakoune"
authors = ["Soc Virnyl Estela"]
date = 2026-03-06T15:25:12Z
[taxonomies]
tags = [
"workflow"
]
+++

Over the past few years, I've been daily driving my favourite editor,
[Kakoune](https://kakoune.org/).

Although, I am too lazy to fully study its capabilities, it's really a modal
editor that actually makes sense for me in terms of how it changed text editing
from Vim.

I tried to pair it up with other multiplexers and so far, I think **tmux** is
the one for me.

# Prior going back to tmux

I tried different terminal multiplexers so far from kitty to tmux to kitty to
[wezterm](https://wezterm.org/) and then [zellij](https://zellij.dev).

[Kitty](https://github.com/kovidgoyal/kitty) was the terminal emulator that I
really loved from 2019-2020. I even remembered trying to create my own small
plugin just to [move around with
neovim](https://codeberg.org/uncomfyhalomacro/erudite.nvim/src/branch/main/lua/keymaps/kitty.lua).

The problem, however is that although neovim has a rich plugin system, it's also
a fast moving target, as the editor has a lot of contributors and experimenting its core
from performance to extensibility. That is good and all but I don't want to maintain
every breaking change of the plugin system.

Hence, I [abandoned it on June 20,
2024](https://codeberg.org/uncomfyhalomacro/erudite.nvim/commit/7c65dad1eef7fc4aafcdfdf3769b17316b9aa473).

I switched kakoune around that time and I noticed that despite its very minimal
features, it is easy to create a plugin for it by utilizing the existing tools
in your environment.

Around that time, I think I have switched to zellij because _Rust_. I agree,
it's a bad childish reason but I also saw zellij's potential. However, I noticed
that I am held back by it by a lot that I think I should go back to tmux.

As for the terminal emulator, kitty, I think I abandoned it too not because it's
a bad terminal but having a multiplexer over a multiplexer seems to be a bad
idea and I am afraid of having conflicting keys and overlapping functionality. I
even tried wezterm + tmux or ghostty + tmux but I just don't feel like there
should be overlaps.

And I don't need ligatures. I was a fan back then of ligatures but because
ligatures are inconsistent across terminal emulators, I decided to just use
alacritty (or foot on Linux).

# Why Tmux?

Honestly, it's easy to write scripts on tmux. It can be done with zellij of course.
But the biggest reason why I prefer tmux over zellij is the default keybinds.

Yes, there is also zellij _tmux mode_ but tmux keybinds do not conflict with kakoune
and that's a thing that I notice when I use kakoune over tmux e.g. reverse-search conflicts
with new pane.

Another thing is customizability. Tmux is very old so a lot of plugins and built-ins were
added over the years as well as guides that help newcomers.

> I actually attempted to check a thing where I have to create a script to
> open `fzf` and pass the selected text for buffer and file selection and
> it seems it's very hard to do with `zellij`. I have to create a helper shell script
> for it e.g. <https://github.com/uncomfyhalomacro/kakudite/blob/main/scripts/fzf-to-kak-client>
> whereas with `tmux`, it's just <https://github.com/uncomfyhalomacro/kakudite/blob/aa9909d5fe8ebca4766b34ff0844186e9402cc80/kakudite/custom-tmux.kak#L83>

Although, `zellij` already has a functionality to move a pane to a tab, it does not have

- an `action` to move a pane to a tab; or
- transform a pane as a tab

It's possible to script it but I think I won't go down that route. With `tmux`, it's just

```bash
tmux break-pane
```

Overall, I just can't with `zellij` for now. It's possible that I can write plugins for it but
I just don't have the time. It's still a good project, and even my friends use it so
if things improve in the future, I might try but I don't think that's very soon:tm:.

