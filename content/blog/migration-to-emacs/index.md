+++
title = "My Migration to Emacs"
authors = ["Soc Virnyl Estela"]
description = "it's the way, and the life 😭"
date = 2023-07-22
tags = ["emacs", "editor", "zola"]
draft = false
[taxonomies]
  tags = ["emacs", "editor", "zola"]
+++

## Why I tried Emacs {#why-i-tried-emacs}

I tried Emacs for the following reasons

-   [org mode](#org-mode)
-   [org roam](#org-roam)

I heard many memes and praises of the editor. But one thing that interests me was that emacs can do note taking
and task scheduling through [org mode](https://orgmode.org). Additionally, note taking using the [zettelkasten](https://zettelkasten.de) through [org roam](https://www.orgroam.com) greatly
enhances that experience!

I tried it for a few weeks now and ... it is amazing! 👀


### Org Mode {#org-mode}

I wouldn't use emacs without this feature. It can allow you to schedule your stuff with [org agenda](https://orgmode.org/manual/Agenda-Views.html). These
includes _note taking_, _task scheduling_, and _dailies_. Hell, combined that with [org roam](https://www.orgroam.com/), and you get
the best of zettelkasten method plus a growing connections of tasks.


### Org Roam {#org-roam}

This feature actually hooked me into using emacs. Without it, my notes would be everywhere without knowing
which part of this note connects to this note. Yes, you can do it by linking URL links but that's not ideal
to do that manually. Org roam does that for you and it's such a breeze.

Lastly, org roam has another plugin called [org roam ui](https://github.com/org-roam/org-roam-ui) which allows you to create a graphical representation
of your knowledge base like how [Obsidian](https://obsidian.md) and other knowledge base note taking apps do. I forked the project
as seen [here](https://github.com/uncomfyhalomacro/org-roam-ui/tree/feature/add-export-functionality) to allow me to generate a static web app for my knowledge base and upload it as a standalone
website. The result is my <https://zettelkasten.uncomfyhalomacro.pl>!

{{ figure(src="/assets/photos/zettelkasten-sample.webp") }}


## Conclusion {#conclusion}

I think I am slowly migrating all of my workflow to Emacs now. I do still use helix for small fast edits but
for powerful features such as task scheduling, todolists and zettelkasten? I guess it's Emacs.

If you want to see how a professional Emacs user use Emacs, you can check out this [link](https://youtu.be/urcL86UpqZc). It's very informative.
