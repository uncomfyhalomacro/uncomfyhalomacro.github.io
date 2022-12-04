+++
title = "Calling Executables Outside Distrobox That Are From Another Distrobox"
authors = ["Soc Virnyl Estela"]
date = 2023-08-06
updated = 2024-01-30
tags = ["container", "distrobox", "podman"]
draft = false
[taxonomies]
  tags = ["container", "distrobox", "podman"]
+++

# Update

This old post is outdated and requires a small update. To run an executable from another
container (here we use distrobox, a frontend for podman or docker), you just need to run
this command inside the desired container where you want to run the executable.

```sh
sudo ln /usr/bin/distrobox-host-exec /usr/local/bin/my-executable
```

Make sure that the `my-executable` was already `distrobox-export`ed to the host.

# Old post

To anyone that might have asked themselves

> How do I call an executable from Y distro to the current X distro I am using in distrobox?

The answer is to **create a script**. But first you will have to use `distrobox-host-exec`. Create a symlink inside your distrobox. You can either declare
an init-hook or do it manually. The command is

```sh
ln -sf distrobox-host-exec /usr/local/bin/podman
```

This will create a pseudo podman executable that will run the host system's `podman`, assuming you have that installed in your host system.

To check if it works, run

```sh
podman ps
```

This will give you a list of available containers that are active.


## Example situation {#example-situation}

So let's assume you are in a weird situation. You want to use [zig](https://ziglang.org) but the one on openSUSE Tumbleweed distrobox is 0.10.0 because it has an
issue with [glibc](https://ziglang.org/download/0.11.0/release-notes.html#glibc-234) versions. But it builds correctly on openSUSE Leap 15.5! The next thing you did was to create your leap distrobox

```sh
distrobox-create -i leap:latest -n leap
```

And then you ran the following command inside your leap distrobox

```sh
sudo zypper addrepo https://download.opensuse.org/repositories/devel:tools:compiler/15.5/devel:tools:compiler.repo
sudo zypper refresh
sudo zypper install zig
```

> So uh... how do I use zig from leap when I am in a tumbleweed distrobox?

By using `distrobox-host-exec` which calls your `podman` executable! Remember the symlink? Here is the idea

`podman` has an `exec` command. Running `podman exec --help` gives you the following output:

```txt
Run a process in a running container

Description:
  Execute the specified command inside a running container.


Usage:
  podman exec [options] CONTAINER [COMMAND [ARG...]]

Examples:
  podman exec -it ctrID ls
  podman exec -it -w /tmp myCtr pwd
  podman exec --user root ctrID ls

Options:
  -d, --detach               Run the exec session in detached mode (backgrounded)
      --detach-keys string   Select the key sequence for detaching a container. Format is a single character [a-Z] or ctrl-<value> where <value> is one of: a-z, @, ^, [, , or _ (default "ctrl-p,ctrl-q")
  -e, --env stringArray      Set environment variables
      --env-file strings     Read in a file of environment variables
  -i, --interactive          Keep STDIN open even if not attached
  -l, --latest               Act on the latest container podman is aware of
                             Not supported with the "--remote" flag
      --preserve-fds uint    Pass N additional file descriptors to the container
      --privileged           Give the process extended Linux capabilities inside the container.  The default is false
  -t, --tty                  Allocate a pseudo-TTY. The default is false
  -u, --user string          Sets the username or UID used and optionally the groupname or GID for the specified command
  -w, --workdir string       Working directory inside the container
```

Since it says here that we can run a process from a running container, we can create a script to run `zig` in your tumbleweed distrobox!

```sh
#!/bin/bash
/usr/local/bin/podman exec --user $USER -it -w $PWD leap zig $@
```

And save it to `/usr/local/bin/zig` and run `sudo chmod +x /usr/local/bin/zig`.


## Testing your zig executable {#testing-your-zig-executable}

Inside your tumbleweed distrobox which now contains your pseudo zig executable, you can test if it works by doing the commands

```sh
md hello-zig/
cd $_
zig init-exe
zig build
./zig-out/hello-zig
```

The last command should output

```txt
All your codebase are belong to us.
Run `zig build test` to run the tests.
```


## How it works {#how-it-works}

We have `distrobox-host-exec` (which calls `host-spawn` in the background), and `podman`. By using `distrobox-host-exec` to
run the host system `podman`, we can also check other running containers, not just from `leap` distrobox in the previous examples.

With `podman`, we can use its `exec` command to run executables _from other containers_. The important flags are

-   `-w` or `--workdir`. This is where you set `$PWD`
-   `-i` or `--interactive`. This allows interactivity
-   `-t` or `--tty`. This will allow it to work somewhat okay-ish in a terminal.

Plus `$@` to add possible other subcommands of an executable e.g. `build`, `test`, `--help`.

The `--user` is set to `$USER` so it respects your user inside the container. Otherwise, it will become `root` which
maybe is not what you want.

So the final and cool command for the pseudo zig executable is:

```bash
#!/bin/bash

# leap can be anything: container ID or container NAME
/usr/local/bin/podman exec --user $USER -it -w $PWD leap zig $@
```


## More information {#more-information}

You can find more information from the following links:

-   <https://distrobox.privatedns.org/usage/distrobox-host-exec/>
-   <https://manpages.opensuse.org/Tumbleweed/podman/podman-exec.1.en.html>
