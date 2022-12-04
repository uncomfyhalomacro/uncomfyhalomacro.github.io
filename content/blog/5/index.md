+++
title = "Writing my own tree-sitter grammar"
date = 2022-12-14
updated = 2023-04-02
description = "and for a good reason"
authors = ["Soc Virnyl Estela"]
+++

[Tree-sitter] is an incremental parsing system that allows developers to add syntax highlighting and tree-sitter regex search for easy navigation.

The project is heavily used among popular editors such as [**neovim**][neovim], and [**helix**][helix].

## The issue

As a volunteer packager for openSUSE, I read rpm specfiles to add, update, and/or modify a package. It was fine with neovim at first but
I use **helix** now as my main editor for modifying specfiles and for doing some changes. 

A comparison between [helix][helix] _right_ and [neovim][neovim] _left_:

<img src="./blog-5-helix-vs-neovim.png.webp" alt="comparing helix and neovim syntax highlighting of rpm" />

As you can see from the image above, helix does not have a syntax highlighter for rpm. Neovim and Vim do but they do not use tree-sitter for
the highlighting of code. I am no expert of how neovim and vim do that without tree-sitter but I can link you to a [blog][cs6120] which summarizes
how it works by implementing syntax highlighting for Bril.

### This poses a problem

Well... for me, not sure for other people. The role of syntax highlighting is to allow us to see each part of the syntax
differently e.g. function, module, variable, etcetera. This increases readability and the time to recognize parts of code
is lessened to an extent. Although, it is not a big deal in most cases because RPM specfiles are usually less than 200 lines,
it gets too complicated for packaging software that have different needs and limitations e.g. julia, and rust. Check out the specfiles for [julia][julia-specfile]
and [rust][rust-specfile] and you will see what I mean.

## Solution

Again, I mainly use helix now as my main editor. And helix does not have the same syntax highlighting functionality like vim's or neovim's.
It uses [tree-sitter][tree-sitter] to do the syntax highlighting. Therefore, I have taken the initiative to write
an RPM grammar for tree-sitter to solve my problems reading specfiles. For now the project is an
empty repository - [https://codeberg.org/uncomfyhalomacro/tree-sitter-rpm](https://codeberg.org/uncomfyhalomacro/tree-sitter-rpm).

I will update later in the future blogs on the progress of this. It's my first time writing a grammar for tree-sitter after all. 😁

<!-- Links -->
[helix]: https://helix-editor.com/
[neovim]: https://github.com/neovim/neovim
[rpmspec]: https://rpm-software-management.github.io/rpm/manual/spec.html
[tree-sitter]: https://github.com/tree-sitter
[cs6120]: https://www.cs.cornell.edu/courses/cs6120/2019fa/blog/vim-syntax-highlighting/
[julia-specfile]: https://build.opensuse.org/package/view_file/science/julia/julia.spec?expand=1
[rust-specfile]: https://build.opensuse.org/package/view_file/devel:languages:rust/rust1.65/rust1.65.spec?expand=1
