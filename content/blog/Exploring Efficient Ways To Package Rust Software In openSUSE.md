+++
title = "Exploring Efficient Ways To Package Rust Software in openSUSE"
authors = ["Soc Virnyl Estela"]
date = 2024-08-22
updated = 2024-11-10
draft = false
[taxonomies]
  tags = ["packaging", "rust", "opensuse"]
+++


> **Update**
> I am moving over some logic as another package called
[roast](https://github.com/openSUSE-Rust/roast). This
is to prepare this vendoring alternative called
[obs-service-cargo-vendor-home-registry](https://github.com/openSUSE-Rust/obs-service-cargo-vendor-home-registry).
The project is still worked on during my free time.

I have re-investigated possible solutions for confusing packaging in Rust. Currently,
we are using `cargo vendor` to vendor package dependencies. This comes at a cost.
- Back and forth copying of `.cargo/config.toml` for possible projects that use monorepo
configurations i.e. workspace and real monorepos.
  - Examples of these are: zellij, wezterm and python-tokenizers
- We always want to ensure `Cargo.lock` and I doubt the solution will not avoid this
since lockfiles are always essential when building software with Rust.
- Existing `.cargo/config.toml` from projects will be overridden with our generated
`.cargo/config.toml`.

The first solution I thought of is a global `.cargo/config.toml` for projects. This
has been done with **python-tokenizers** in openSUSE because it is possible to use
`--manifest-path` to specify a manifest `Cargo.toml` file in the specfile for cargo
invocations.

Seeing this, I realised, why not just use the `$CARGO_HOME` since we are pointing at a global cache anyway? This blog is about tracking my future project
<https://github.com/uncomfyhalomacro/obs-service-cargo-vendor-home-registry> of which I plan to integrate into <https://github.com/Firstyear/obs-service-cargo> as an alternative vendor generating utility for Open Build Service or OBS.

# Storage size eaten by `CARGO_HOME` vs `cargo vendor` comparison

> **NOTE**
> `cargo fetch`, `cargo vendor`, `cargo build`, and `cargo generate-lockfile` all update the `CARGO_HOME` or what we call the cargo home registry or just cargo home. We use `cargo fetch` here because it's designed to update the registry cache instead of other commands.
>
> **WARNING** Behaviours between `cargo fetch` and `cargo generate-lockfile`
> `cargo fetch` updates the registry to latest version of crates and also regenerates `Cargo.lock` to reflect the versions unless `--locked` flag is passed where it tries to respect the versions of the crates from the existing `Cargo.lock` despite this *contradicting* description in the manpage that 
> If a Cargo.lock file is available, this command will ensure that all of the git dependencies and/or registry dependencies are downloaded and locally available. Subsequent Cargo commands will be able to run offline after a cargo fetch unless the lock file changes.
>  
>  However, `cargo generate-lockfile` updates the registry + updates the `Cargo.lock` which in my opinion is just a duplication of the other cargo sub-command `cargo update`. Why? Both do the same behaviour. Even the part where you pass `--locked` will give you the same error "**error: the lock file /run/host/tmp/jay-1.4.0/Cargo.lock needs to be updated but --locked**".


Here are the zstd compressed tarballs for the following after running the cargo commands 

**wezterm**
- `cargo-vendor`: 1.1GB
- `cargo-fetch`: 1.3GB

**jay**
- `cargo-vendor`: 24MB
- `cargo-fetch`: 76MB

**zellij**
- `cargo-vendor`: 66MB
- `cargo-fetch`: 133MB

Why does it seem like `cargo-fetch` duplicates the contents in the tarball? Because it really does. The registry contains the following directory structure

```
.
└── registry
    ├── cache
    │   └── index.crates.io-6f17d22bba15001f
    ├── index
    │   └── index.crates.io-6f17d22bba15001f
    └── src
        └── index.crates.io-6f17d22bba15001f

8 directories, 0 files

```

One can remove the `.cargo/registry/src` directory as that contains the extracted crates and then create a `tar.zst` file using the following commands

```bash
# Assuming $CARGO_HOME is set to $PWD/.cargo
pushd .cargo
rm -rfv registry/src
popd
tar --zstd -cvf vendor.tar.zst .cargo/
```
# How to get cache from `$CARGO_HOME`

Any of these commands will generate the cargo home registry cache
- build
- generate-lockfile
- vendor
- fetch
- update

~~Some commands are duplication of the other commands i.e. update and
generate-lockfile. It's just that the former prefetches the latest crate versions
while the latter doesn't.~~

To update the registry cache, one must either go with `cargo fetch` or even `cargo
vendor` to avoid building or updating (unless update is set).

All commands try to regenerate the `Cargo.lock` with the latest compatible MSRV. If
`--locked` is passed, it will try to attempt to respect the versions in the `Cargo.lock`.
However, if the version of a dependency in `Cargo.lock` got yanked and there is a
newer version, then an operation with `--locked` will fail. Also, passing `--locked` to
`cargo-update` is ambiguous as it will always almost fail since it tries to update the
`Cargo.lock`.

### Why not go with `cargo vendor --sync`

Reason? Uncertainty of how that command respect `Cargo.lock` for each crate. I would
rather have do
	
```bash
cargo fetch --locked --manifest-path=path/to/Cargo.toml
```

for each manifest found since one can flexibly turn `--locked` on and off.

# Building now with `$CARGO_HOME`

It's always has been possible to use `$CARGO_HOME`, specifically, `$CARGO_HOME/registry`.

There was an attempt in this repository, <https://github.com/openSUSE-Rust/obs-service-cargo-vendor-home-registry>.

Now, that project has been merged into <https://github.com/openSUSE-Rust/obs-service-cargo>.

You can see this working in <https://build.opensuse.org/package/show/editors/kak-lsp>. But we lied a bit here.
We will explain that in the later sections.

## Path dependencies in `Cargo.toml` needs to be revisited 

Membered crates (in workspace configurations) and local crates (both are local and in path actually)
should also be taken consideration when vendoring dependencies.

For example, <https://build.opensuse.org/package/show/science:machinelearning/python-tokenizers> have
two different dependencies that are actually related to each other.

The solution to this is to eagerly check their manifest and lockfiles. Hence, either with multiple vendor
tarballs or a vendored `$CARGO_HOME`.

## Lockfiles are always inconsistent

See <https://github.com/rust-lang/cargo/issues/7169>. This is a glaring issue
and not just for `cargo install` but almost all cargo commands such as `cargo
fetch`. That's why in openSUSE, we try to include the lockfile as much as
possible even if passing `--locked`. I think I would agree to this comment
<https://github.com/rust-lang/cargo/issues/7169#issuecomment-539226733>.

Observation
- `cargo fetch --locked` does not work because it tries to keep the registry cache updated
- `cargo vendor --locked` works because I don't know why???

Now is the use of `--sync` idea thrown out the window?

For crates that don't ship with a lockfile, we will run either`cargo generate-lockfile`
or `cargo update`, former is more semantically correct to do as opposed to `cargo
update`. But `update` makes sense the most because we are going to add update options
on the new project anyway.

## `cargo-fetch` vs `cargo-update`

Two days ago as of writing, I filed a bug report regarding inconsistencies
between `cargo-fetch` and `cargo-vendor`. Link to bug report
<https://github.com/rust-lang/cargo/issues/14795>.

The inconsistency specifically is the way the two handle dependencies differently
especially when it comes to `cargo-fetch`'s `--target` flag.

I had high hopes that by default[^but not really], it gets **all** target architectures. But I was
met with failed builds on ~~not so commonly used~~ architectures whereas vendored
dependencies from `cargo-vendor` compiles. They fail because they cannot find their
dependencies fetched from `cargo-fetch`.

I will just have to wait for a feedback regarding how `cargo-fetch` behaves as compared
to `cargo-vendor`. I believe though that both should be at least similar in almost
all aspects.

[^but not really]: This is still not a ***loss*** yet for me since most of the software I used in openSUSE
are used by people who either use x86_64 and aarch64. I don't believe that the other
architectures are used commonly so I have removed support.
