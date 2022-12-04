+++
title = "Juliaup is the next generation version manager for Julia"
date = 2023-05-16
authors = ["Soc Virnyl Estela"]
+++


The [Julia](https://julialang.org) programming language has gained more improvements over the years. The latest
version as of writing is 1.9.0 - one of the biggest improvements of Julia in the 1.x series. Hoping more to come!

# What is Juliaup?

`juliaup` is a version manager for Julia much like `pyenv` or `rbenv`. It's functionality closely aligns with `rustup`.

If you want to know more, check out their github repository at [https://github.com/JuliaLang/juliaup](https://github.com/JuliaLang/juliaup).

# Why should you use Juliaup?

The usual way of downloading release binaries at the official website is not really much of a hassle. However, 
downloading different versions of Julia can take more time to browse around.

There are two version managers for Julia: [jill.py](https://github.com/johnnychen94/jill.py) and [juliaup](https://github.com/JuliaLang/juliaup).

As you may have noticed, `jill.py` is a python script that installs Julia and `juliaup` is written in Rust. I cannot compare
their differences as I never tried the former. I suggest you try either one of them. 

Installing a Julia release channel in `juliaup` is quite easy. To check available channels, you run `juliaup list`. To add a channel, say 1.5.0,
you run `juilaup add 1.5.1`. To make a channel the default, you run `juliaup default 1.5.0`.

For me, you should use `juliaup` since it includes features such as the ability to run a version (as long as it is added)
using their own Julia caller called `julialauncher`. You can symlink or alias that as `julia`. For example, if you want to run version 1.6.0, 
you can do so by running `julialauncher +1.6.0` or `julia +1.6.0`.

There is plan in the future releases to make a duplicate launcher of `julialauncher` that is called `julia`. I do believe
it will just add more confusion though. I just symlink it instead. But that is because `juliaup` has not been hosted
yet on [crates.io](https://crates.io). See issue [#639](https://github.com/JuliaLang/juliaup/pull/639).

# Anything to improve?

I think a feature I want to have in `juliaup` is this one - [https://github.com/JuliaLang/juliaup/issues/10](https://github.com/JuliaLang/juliaup/issues/10).
I do think that the idea of having `juliaup.toml` in the root directory of a project is convenient. Rust does that with `rust-toolchain.toml`. But again,
it is up to debate because there were some issues of maybe duplicating the functionality of `Project.toml` and `Manifest.toml` and selecting the version
inside those two configuration files mitigates that issue rather than using `juliaup.toml`. The workaround for now is to use
the `JULIAUP_CHANNEL` environmental variable with `direnv` or whatever env "manipulation" tool you use.

Again, if you want to explore `juliaup`, you can do so by checking first the repository at [https://github.com/JuliaLang/juliaup](https://github.com/JuliaLang/juliaup).

If you use [openSUSE](https://get.opensuse.org), just run `sudo zypper in juliaup` and you are good to go.
