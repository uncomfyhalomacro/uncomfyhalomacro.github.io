+++
title = "How I use MicroOS Desktop"
date = 2023-05-28
authors = ["Soc Virnyl Estela"]
[taxonomies]
tags = ["linux", "container", "workflow", "desktop"]
+++

# Update on my current usage

**I stopped using it**. MicroOS has some of it's perks but the current state of the operating system is still in it's beta/alpha state
so some moving parts are inherently broken. It's probably because of the lack of contributors and interest from SUSE and openSUSE
for the desktop variant of MicroOS. As much as I want to become a contributor, I realize I lack the time to do so because
of work and personal problems and issues I still have to fix a lot in real life. If you still want to know how I use it, continue reading.

---

MicroOS Desktop is a _desktop variant_ of the openSUSE's MicroOS for servers and containerized workflows. Please do note, although they are
similar, they are separate products and have different goals. 

> Issues in MicroOS for server should be issued over there and issues in MicroOS Desktop
should be on MicroOS Desktop.

The goal of the desktop is as follows:

- immutability
- isolation of system and user software
- containerized workflows

## Immutability

Immutable desktops are nothing new. Windows and MacOS are immutable desktops since _you cannot
change the core part of the system_ unless you have some permissions and workarounds to do it e.g.
modifying the system registry. For years, this was the standard of modern OSses including Android.

Traditional desktop linux and nix systems are *mutable* which means that the user can modify
each part of the core system. Although this advantage is also a disadvantage, nothing is perfect.

### Advantages of an immutable system

Being immutable is inherently an advantage of an immutable desktop system. It is hard to
modify the core part of the system and updates are "atomic" which means the whole system
will update as an immutable system. 

Users are encouraged to use workflows through sandboxing or containers. In this case, **flatpaks**,
**nix**, **distrobox**, **toolbx**, **docker** and **podman**.

For desktop software, it is advisable to use flatpaks. _Some users do use toolbx and distrobox for this_.

For development environment, they are encouraged to use distrobox and toolbx. Others may prefer nix.

### Disadvantages

Being immutable ***may*** also be a disadvantage. It's very self-explanatory. You cannot modify
your system as much as you like to.

### Security

Immutable desktops increases security of the core system since it's not welcoming any modifications.
Since the root file system is read-only, it's not easy to tamper the system and thus, users
can avoid any vulnerabilities ***unless the vulnerability is from the package and software installed 
from the root file system***.

## My Workflow

For software that I want to use e.g. Firefox, flatpaks are the way to go. Flatpaks are the best
when it comes to these kind of distributions as they are self-contained and do not pollute
the host system with ridiculously brittle and large dependencies when installing through
the system's package manager.

For developing and packaging software and also for learning, and note taking, I use distrobox.

### How I use distrobox

I created `mainbox` executable.

```bash
#!/usr/bin/bash

distrobox enter -n tumbleweed $@
```

This is for my development environment such as notetaking, learning a new language, or programming tasks.

I also created `rootbox` executable.

```bash
#!/usr/bin/bash

distrobox-enter --root --name opensuse-build-service $@
```

This is for openSUSE Build Service related stuff since I am a volunteer packager there. I also set
the `--home` flag when creating this podman container. The `--home` flag helps you have a custom
`$HOME` inside your container. It avoids clutter on your *actual home directory*.

# Conclusion

For now, I am still new to MicroOS Desktop and I still experience some bugs here and there because
I use the KDE Plasma variant of MicroOS which is known to be still in it's **alpha** stage. This
means, it's not yet considered for daily use _even though some users are now using it_. To help
improve the experience, it's best to file bug reports and propose suggestions to the MicroOS
Plasma Desktop maintainers and contributors. If you are privileged to have the free time to
contribute, consider offering your skills and services as well.

# Troubleshooting

## Blurry fonts on KDE Plasma

Install all the `xdg-desktop-portal` implementations especially gnome and gtk. Blurry fonts are usually affecting
gtk apps and not qt apps.

# Issues

NVIDIA drivers don't load as fast causing some issues with the login manager. Workarounds is a force `systemctl restart display-manager.service`.
I am not sure what's causing it as there are no logs. This does not happen on vanilla openSUSE TumbleWeed.

