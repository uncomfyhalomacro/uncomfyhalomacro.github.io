+++
title = "Packaging Crystal Software for openSUSE"
authors = ["Soc Virnyl Estela"]
description = "a tutorial on how to package Crystal software"
date = 2023-07-31
tags = ["crystal", "opensuse", "packaging"]
draft = false
[taxonomies]
  tags = ["crystal", "opensuse", "packaging"]
+++

## Prerequisites {#prerequisites}

You will need the following:

-   `osc` and `obs-service-download_files`
-   your editor of choice e.g. emacs, helix
-   `tar`
-   familiarity of how to use <https://build.opensuse.org/>. See <https://en.opensuse.org/Portal:Packaging> for guides. Fedora has one too, see <https://docs.fedoraproject.org/en-US/packaging-guidelines>.
-   `crystal`

Check with zypper if `osc` is installed.

> **Tip**: Use the `cnf` command to check which package `osc` comes from.
>
> ```sh
> cnf osc
> ```


## Recipe {#recipe}

The following subtopics explain how to package crystal software step-by-step. Adjust accordingly based on your setup.


### Create a new package {#create-a-new-package}

You can do it at <https://build.opensuse.org/> but if you prefer the commandline,
you can do for example

````sh
osc mkpac blahaj
cd blahaj
````

In this tutorial, we will try to package [BLAHAJ](https://github.com/GeopJr/BLAHAJ) using the [shards](https://github.com/crystal-lang/shards) project and dependency manager for
[Crystal](https://crystal-lang.org) and `tar`.


## Package without a dependency {#package-without-a-dependency}


### Write the specfile {#write-the-specfile}

Using your preferred editor, create a file named `blahaj.spec`. The following prelude should be enough for the specfile:

````txt
Name: blahaj
Version: 2.1.0
License: BSD-2-Clause
Summary: Gay sharks at your local terminal
Url: https://github.com/GeopJr/BLAHAJ
Source0: https://github.com/GeopJr/BLAHAJ/archive/refs/tags/v2.1.0.tar.gz#/%{name}-%{version}.tar.gz
Source1: vendor.tar.zst
BuildRequires: crystal
BuildRequires: shards
BuildRequires: make
````

> How do I have `shards` and `crystal`?

You can branch packages from my home project at Open Build Service - <https://build.opensuse.org/project/show/home:uncomfyhalomacro>. Or even just add an repository
image of that project. I have `shards` and `crystal` there. The latter can also be found at <https://build.opensuse.org/package/show/devel:languages:crystal/crystal> if
you want that too.

For the sake of simplicity, we will assume that we are going to use `crystal`, `shards`, and `make` at your home project in Open Build Service.

Add the following sections: description, prep, build, install, files and changelog section.

````txt
Name: blahaj
Version: 2.1.0
Release: 0
License: BSD-2-Clause
Summary: Colorize your terminal with gay sharks
Url: https://github.com/GeopJr/BLAHAJ
Source0: https://github.com/GeopJr/BLAHAJ/archive/refs/tags/v2.1.0.tar.gz#/%{name}-%{version}.tar.gz
BuildRequires: crystal
BuildRequires: shards
BuildRequires: make

%description
Apart from a cute cuddly shark plushie from IKEA, BLÅHAJ is a lolcat-like CLI tool
that colorizes your input, shows flags and prints colorful sharks!

It has a wide variety of flags/colors to choose from and many options from flag size
to whether to colorize by line, word or character.

%prep

%build

%install

%files

%changelog
````

At the root of your project package e.g. `home:yourusername/blahaj`, run `osc service localrun download_files`. You will get a file called `blahaj-2.1.0.tar.gz`.
Extracting the file gets us the directory `BLAHAJ-2.1.0/`. This means that in our `%prep` section, we need to add `%setup -qa1 -n BLAHAJ-%{version}`. This is to
redirect the rpm macros that building should be at `RPM_BUILDDIR/BLAHAJ-2.1.0/` since by default, it is `RPM_BUILDDIR/nameofpackage-version/`
based on the `Name:` and `Version:` RPM specfile prelude.


### Building and Installing the package {#building-and-installing-the-package}

The following sections should be easy here since `make` as build dependency has convenient macros such as `%make_build` and `%make_install`.

````txt
Name: blahaj
Version: 2.1.0
Release: 0
Summary: Colorize your terminal with gay sharks
License: BSD-2-Clause
Url: https://github.com/GeopJr/BLAHAJ
Source0: https://github.com/GeopJr/BLAHAJ/archive/refs/tags/v2.1.0.tar.gz#/%{name}-%{version}.tar.gz
BuildRequires: crystal
BuildRequires: shards
BuildRequires: make

%description
Apart from a cute cuddly shark plushie from IKEA, BLÅHAJ is a lolcat-like CLI tool
that colorizes your input, shows flags and prints colorful sharks!

It has a wide variety of flags/colors to choose from and many options from flag size
to whether to colorize by line, word or character.

%prep
%setup -q -n BLAHAJ-%{version}

%build
%make_build

%install
%make_install

%files
%{_bindir}/blahaj
%doc README.md CODE_OF_CONDUCT.md
%license LICENSE

%changelog
````

As for `%files`, you can just do a "best guess" or "best observation" approach. Here, we based it from the `Makefile` and for documentation and license, those are
self-explanatory.

Changelog can be left as is since we are not Fedora 😘. We use `blahaj.changes` for that generated with `osc vc`. It creates a temporary file you can edit
from like below

````txt
-------------------------------------------------------------------
Mon Jul 31 12:34:07 UTC 2023 - Your Name <youremail@example.com>

- Initial spec for blahaj 2.1.0

````


### Add the files {#add-the-files}

Add the files by running the command

````sh
osc add blahaj.spec blahaj-2.1.0.tar.gz blahaj.changes
````

And then push it to your home project at Open Build Service with `osc ci`, which allows you to check the diff and see what was changed based from the
`blahaj.changes` file.


### Check if it builds correctly {#check-if-it-builds-correctly}

Now check your new blahaj package at your home project. If it fails, investigate what went wrong! Check mine at
<https://build.opensuse.org/package/show/home:uncomfyhalomacro/blahaj>.

> **NOTE:**
> It seems at the time of writing, I missed some dependencies or optional dependencies for
> crystal! Anyway, _I am confident_ it will build this correctly after that's fixed.


## Package With dependencies {#package-with-dependencies}

This is where `tar` and `shards` comes in. An example of this is `shards` itself. See <https://build.opensuse.org/package/show/home:uncomfyhalomacro/shards>.

What I did here is at the root of the project e.g. home:yourname/shards, I extracted the shards source tarball, `tar xvf shards-0.17.3.tar.gz`. Changed directory
to the extracted directory, `shards-0.17.3/` and then ran `shards check` and `shards install`. You will get a new directory called `lib/`. This is where you
_vendor_ your dependencies like how Rust and Go do.

To _vendor_ it, it's simple. Just run

````sh
tar --zstd -cvf vendor.tar.zst lib/
````

Copy `vendor.tar.zst` to the root of the project package folder. Add it to one of the sources of your project and adjust your `%setup` with flags `-qa1`
which `a1` means extract `Source1: vendor.tar.zst` to the root of `RPM_BUILDDIR/shards-0.17.3` including the root folder of the archive `lib/`.

This will create a new directory called `lib/`, and contains other crystal packages that are dependencies of that project.

Then I just used `crystal` to build `shards` as seen from the build section and do a manual install with `install` command at the install section.


## Other possibilities {#other-possibilities}

You can also remove `make` or `shards` as well if you prefer just using `crystal` on the build section.
