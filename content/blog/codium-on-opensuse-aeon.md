+++
title = "VSCodium Flatpak on openSUSE Aeon"
authors = ["Soc Virnyl Estela"]
description = "a small short guide on how to setup VSCodium Flatpak on an immutable desktop"
date = 2023-07-14
updated = 2023-07-15
tags = ["workflow", "container", "aeon", "kalpa", "flatpak"]
draft = false
[taxonomies]
  tags = ["workflow", "container", "aeon", "kalpa", "flatpak"]
+++

## Prerequisites {#prerequisites}

To start, you must have an immutable linux desktop distribution such as openSUSE Aeon. In this short post,
I will explain how to set up VSCodium Flatpak in an immutable linux desktop. Some of the steps
can be imitated to other immutable distros such as Fedora Silverblue and VanillaOS.

### Reason {#reason}

There are ongoing issues and questions amongst Linux users and skepticisms regarding the usability of
immutable desktops and the push for an all **flatpak** (or **snap**, if you prefer that,) immutable desktop
distribution.

This post, however, only debunks misinformation of how to use VSCodium Flatpak (or even VSCode Flatpak) properly
in this kind of system.


## The Guide {#the-guide}

### Setting up Flatpak {#setting-up-flatpak}

openSUSE Aeon already has flatpak set up out of the box but it's `system-wide`. If you prefer _user-wide_ installations, you can do:

```sh
flatpak --user remote-add \
        --if-not-exists flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo
```

### Installing VSCodium Flatpak {#installing-vscodium-flatpak}

Assuming you use openSUSE Aeon, you can install VSCodium Flatpak through GNOME Software. If you love to use the
CLI, you can do the following:

#### User-wide install {#user-wide-install}

```sh
flatpak --user install com.vscodium.codium
```

#### System-wide install {#system-wide-install}

```sh
flatpak install com.vscodium.codium
```

Then install Open-Remote-SSH Plugin for VSCodium - <https://github.com/jeanp413/open-remote-ssh>.

### Setting up distrobox {#setting-up-distrobox}

openSUSE Aeon comes with [distrobox](https://github.com/89luca89/distrobox) out of the _box_ 😜

Distrobox is a [podman](https://podman.io) frontend much like [toolbx](https://github.com/containers/toolbox). I prefer distrobox because it's way more flexible in my experience.

To create my own container, I run the following command

```sh
distrobox-enter tumbleweed
```

This will create a podman container named as "tumbleweed". I advise you to set a **custom** `HOME` directory
though. You can do that by using the command

```sh
distrobox-create -n tumbleweed -H somedir/you/really/want/to/set/as/HOME/for/that/container
```

For more information, check out the documentation at <https://distrobox.privatedns.org/usage>.


### Setting up SSH and SSHD in your container {#setting-up-ssh-and-sshd-in-your-container}

After entering your container (here we use "tumbleweed"), do

```sh

sudo /usr/sbin/sshd-gen-keys-start
# assuming you have vim installed in the podman container
# I use vim here
sudo vim /etc/ssh/sshd_config
```

Then add the following to your `/etc/ssh/sshd_config` in that container

```txt
Port 10000
ListenAddress localhost
PermitEmptyPasswords yes
PermitUserEnvironment yes
X11Forwarding yes
```

Next, run the `sshd` command like so

```sh
sudo /usr/sbin/sshd
```

Make sure the container is running during all of your sessions. Distrobox does it by default.

Then in your **host system**, edit `~/.ssh/config` with the following content

```txt
Host tumbleweed
  HostName localhost
  Port 10000
```

Finally, use your Open-Remote-SSH plugin in VSCodium to connect to that container and set up your
development environment!


## Conclusion {#conclusion}

Setting up VSCodium flatpak is complicated but not that hard as long as you are familiar with how containers
work and how to choose the right plugins. I believe that a development environment that is mostly SSH-ing
to containers bring benefits that outweighs its disadvantages:

-   clean base system; install dev dependencies in the container
-   throw the container away to start fresh if desired
-   allows developers to install only the necessary stuff on their base system
-   encourages the use of flatpaks, a universal distribution/packaging format
-   explores possibilities of making immutable desktops as a viable development environment

