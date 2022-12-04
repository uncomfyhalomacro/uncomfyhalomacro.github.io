+++
title = "I decided to move back to helix"
date = 2023-09-30
authors = ["Soc Virnyl Estela"]
[taxonomies]
tags = ["editor", "workflow"]
+++

Emacs is good but it's not for me.

<!-- more -->

I feel more productive with helix. And I decided that using helix is the
best way to do things.

# So why helix?

To be honest, helix's keymappings make more sense to me. It feels more
intuitive to use unlike Emacs' `C-x C-c` and `C-x C-s`. I kind of understand
now what the "Emacs Pinky" means.

Helix well designed keymaps (opinion and bias from me) gives me high efficiency
in coding and fixing stuff.

## For taking notes

### My note taking habits

I take notes... but not frequently. To be honest, I only take notes if I feel
like it's something important but my brain does not deem it so. I usually
remember stuff easily if I condition myself that _it is important_.

So that's why I decided to use `zk` + `helix` + `zellij` since for me I
usually make a todo list rather than taking notes.

I think `zk` is fine. As long as I don't plan to publish my notes as some sort
of static or dynamic website. I feel like I was planning to post my notes just
for "showing off". To be honest I don't feel happy taking notes through emacs.


## For programming 

I use `lsp-mode` and it's so slow to be honest. This is because of emacs
being single threaded and files with 300 LoC slows it down considerably when
ran on emacs.

With helix's native tree-sitter and LSP support, plus the amazing async
capabilities it has because Rust and cool devs, it feels fast and does not
slow me down waiting for UI to pop up or to format the whole file. Helix
can handle more LoC with no lags and slowdowns.

Multi-cursor and multi-selections is well supported on Helix. I don't have
to deal with an `.mc-list` which for me is just a hack to avoid Emacs'
weird behavior when doing multiple cursor / selections, for which is a hack
(a well thought out hack) by itself to make Emacs have multi-cursors.

