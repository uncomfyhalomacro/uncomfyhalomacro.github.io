+++
title = "Setting up Julia LSP for Helix"
date = 2023-05-19
authors = ["Soc Virnyl Estela"]
[taxonomies]
tags = ["setup", "editor", "helix", "julia", "lsp"]
+++

The [Julia][Julia] programming language is a popular general programming language where the
community leans more on scientific computing. And like most programming languages, Julia code
can be written on most text editors such as IDEs.

Most editors today contain a set of tools such as git integration, built-in terminal, and a
file picker and finder. Some editors that I tried are of the following:

- [Visual Studio Code][VSCode]
- [Vim][Vim]
- [Neovim][Neovim]
- [Emacs][Emacs]

# Setting up Julia LSP for Helix

[Helix][Helix] is a new editor I daily drive since a year ago. It follows a different style of
editing than Vim/Neovim. It's model and keymaps are influenced from [Kakoune][Kakoune] which
follows a select-action-execute model unlike the usual Vim action-select-execute model. I've been
liking it so far! 

As this post is about setting up LSP for [Helix][Helix], setting up LSPs on other editors are
pretty straight-forward e.g. Julia plugin on VSCode.

With helix, you have to write a simple configuration, specifically at `languages.toml`.

## Writing the Julia LSP script for the LSP

As helix does not have the option to pass the value of the current working directory of the file or buffer 
(maybe I am wrong, do correct me though!) unlike neovim's `%:p:h`, our script is like so:

```julia
import Pkg
project_path = let
    dirname(something(
        Base.load_path_expand((
            p = get(ENV, "JULIA_PROJECT", nothing);
            isnothing(p) ? nothing : isempty(p) ? nothing : p
        )),
        Base.current_project(pwd()),
        Pkg.Types.Context().env.project_file,
        Base.active_project(),
    ))
end

ls_install_path = joinpath(get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")), "environments", "helix-lsp");
pushfirst!(LOAD_PATH, ls_install_path);
using LanguageServer;
popfirst!(LOAD_PATH);
depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
symbol_server_path = joinpath(homedir(), ".cache", "helix", "julia_lsp_symbol_server")
mkpath(symbol_server_path)
server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path, nothing, symbol_server_path, true)
server.runlinter = true
run(server)
```

To understand what it's doing, the main focus of this script is actually the `project_path` variable. We first
check if there is a `JULIA_PROJECT` environmental variable, explicitly set by the user. `Base.load_path_expand`
achieves this. If there is none or if it is empty e.g. empty string, return `nothing`.

If the previous returns `nothing`, we use the `Base.current_project(pwd())`. And if it does not detect
a `Project.toml` file from the current directory, we will fallback to `Pkg.Types.Context().env.project_file`
and `Base.active_project()`.

The `project_path` variable is very important as this will help us check which project you are in and
where to run the LSP.

Julia's LSP is provided by [LanguageServer.jl](https://github.com/julia-vscode/LanguageServer.jl). But
I don't like installing it on the global environment, hence, we have the `ls_install_path` variable.
This `ls_install_path` variable assumes that you have installed the language server on one of the many `DEPOT_PATH`.
Here, I assumed it has to be at `~/.julia/environments/helix-lsp`. We need this variable because we need to
add that path to the `LOAD_PATH`. You can check what `LOAD_PATH` is in the Julia REPL. Basically, it's just an
array of paths where we load our environment for `using` and `import` statements. By default, it has a path
to the global environment. This is why I have to add the `popfirst!` function since I don't want to use that one.

`depot_path` and `symbol_server_path` are optional but I like to make sure that `JULIA_DEPOT_PATH` exists.

Lastly, we then initialize the `server` by setting the `LanguageServerInstance` and setting the linter to `true`. We
then run the `run` function with the `server`.

## Adding it to `language.toml`

Once we are done, we can finally either add it to a script file that can be executed within your `PATH` or just plain
execute it like `julia --project=@helix-lsp path/to/scriptfile.jl`.

Here is a sample:

```toml
[[language]]
name = "julia"
scope = "source.julia"
injection-regex = "julia"
file-types = ["jl"]
roots = ["Project.toml", "Manifest.toml", "JuliaProject.toml"]
comment-token = "#"
language-server = { command = "julia", args = [
    "--project=@helix-lsp",
    "--sysimage=/home/uncomfy/.julia/environments/helix-lsp/languageserver.so",
    "--startup-file=no",
    "--history-file=no",
    "--quiet",
    "--sysimage-native-code=yes",
    "/home/uncomfy/.local/bin/julia-lsp.jl"
    ] }
indent = { tab-width = 4, unit = "    " }
```

It is up to you if you want to use PackageCompiler.jl to create a sysimage and make the LSP faster. Fortunately,
you don't really need it since version 1.9.0 is very fast now.

# There is `runserver`, why not use that?

There are some gotchas with using `runserver`. If I can recall correctly, my issue was it cannot detect the correct paths
inside `helix` and my script for neovim and kakoune is to detect where the file is located and if the location contains `Project.toml` or `Manifest.toml` 
and set it as the `env_path`. This can be seen with my [kak-lsp](https://github.com/kak-lsp/kak-lsp) julia config at line [168-170](https://github.com/kak-lsp/kak-lsp/blob/52197dde1a1c5e997a3ad989a8dfdd8017056a3b/kak-lsp.toml#L168-L170)
on the default `kak-lsp.toml`

As you may noticed, it's not in the script we have discussed before this section. So I probably must have forgotten why 
I wrote that script only to end up that there is no way to check the path to the buffer or file. **Therefore, I recommend to run helix within the root
of your Julia project**.

Let me know if you are not experiencing any issues with `runserver` since someone suggested that it works 
perfectly fine now. See [https://github.com/helix-editor/helix/issues/669#issuecomment-1207489723](https://github.com/helix-editor/helix/issues/669#issuecomment-1207489723)


[Emacs]: https://www.gnu.org/software/emacs/
[Helix]: https://helix-editor.com/
[Julia]: https://julialang.org
[Kakoune]: http://kakoune.org/
[Neovim]: https://neovim.io/
[Vim]: https://www.vim.org/
[VSCode]: https://code.visualstudio.com/
