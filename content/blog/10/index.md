+++
title = "Is Linux (as a desktop) normie friendly already?"
description = "we are not there yet and maybe for a long time"
date = 2023-04-27
updated = 2023-04-29
authors = ["Soc Virnyl Estela"]
[taxonomies]
tags = [
  "linux",
  "desktop",
  "workflow"
]
+++

# Disclaimer

I am not really a fan of fighting over which operating system people use, but I do hate
Arch elitists because most of them are morons.

# My introduction to Linux

I became a linux user since the start of the COVID-19 pandemic because I need to have a working computer that
works with the slowest hardware which was a Lenovo IdeaPad with Intel i3 (two cores with SMTP) and 8GB RAM. 
I forgot the exact spec, but it was around there. But I think I am not like other first time users. Instead
of going with Ubuntu as it is the most popular distro, I started with Debian stable. And yes, of course it has
outdated packages which for me at that time was not relevant as I only need it for mundane tasks such as
writing documents and moving files around. After a few months, I distrohopped to Kubuntu, Xubuntu, Artix, Manjaro
and on the New Year of 2021, I hopped to Arch and stayed there for 6 months. The reason I found myself in 
rolling release distros is that I want to have the latest bleeding edge software. However, the desktop
experience between different release models seems to be similar nor different. Because the fundamentals of a desktop
is for it to be used as one with the most basic of software. However, I am not saying there are no flaws
using Linux as a desktop.

# Linux as a desktop

Desktop Linux is not as popular. However, just because it's not as popular, it does not mean that it is not usable. 
During my first time using Debian and ignoring the fact that the installer menu is very dated, the desktop experience was alright and I have not experienced some funky
things except that the software there is always outdated in Debian stable. Given the simplicity of my use cases
for a desktop e.g. web browsing, writing documents, and moving files around, it seems using Linux as a desktop
is not really a problem for me. But for those that want to use Photoshop, well tough luck, you are on your own
as those proprietary software do not really support linux. But hey, if you have old hardware, Linux is your only
choice unless you want to try the BSDs.

## Okay, so are there any problems?

No software is perfect nor any concept is ideal. Free and open source software is one and this affects desktop
Linux adoption.

### Desktop Linux is dependent on the Desktop Environment

I can't simply not emphasize this one. 

> Your desktop environment in Linux can actually determine your overall
desktop Linux experience.

A desktop environment in Linux is basically a set of desktop tools from related toolkits that create a full
desktop experience. Popular desktop environments include

- KDE Plasma. Based on the QT Toolkit.
- GNOME. Based on GTK Toolkit
- XFCE. Based on GTK as well.

So why is this important? Because some users blame the distribution of Linux that they're using instead of
the desktop environment. And thus, they can be deceiving for newcomers because newcomers will think distro X is bad
because distro Y has this, when they are actually just comparing GNOME over KDE Plasma.

> Having many choices is a double-edged sword, it's the same on desktop environments

But it does not mean we should just keep it at that. We should educate newcomers that it's the desktop environment
they are looking and not the distribution. So instead of suggesting them to "use Arch linux" just for the superiority 
complex, suggest them KDE Plasma and tell them GNOME sucks because it does not have a system tray. \*Pitch forks flying where?\*

**Another disclaimer**: Just because I hate this part of GNOME, does not mean I hate GNOME as a whole. It's just a joke with added
hint of [truth](https://linuxiac.com/gnome-background-apps) 😛

So my take here is, use the desktop environment you are more familiar with and you find the most intuitive to use.

### Software availability can be brittle

One thing I like about Linux is the amount of software availability. Want an office suite? Use Libreoffice.
Want an image editor? Use GIMP or Krita. And there is no end to it. I think this in my opinion is what makes
Linux a good choice in using it as a desktop. However, although it's an advantage, remember that we are talking
about *free* software. And free software can be *brittle*.

#### The problem with free and open source software

> Freedom and free can be easily overly used and abused

It can be. I appreciate the efforts that are put into these software. But I have my reasons for why being
free can be a problem.

> Software availability does not equate to software quality

Yes. Just because it's available, it does not mean you get the quality you want like from proprietary software
as well. Proprietary software can be low quality though. However, what I am saying is that, it is hard
for FOSS to achieve similar quality unless there are incentives.

Money, is undoubtly, one of the driving force to keep FOSS alive through funding. I remembered reading
an article stating that GNOME was close to dying because of the lack of funding.

"But you are a FOSS enthusiast right?", I am and hear me out. I think the issue about being free
is the fact that most people interpret ***free*** as in ***free beer***. This means that people who
contribute and/or maintain FOSS software does not need any incentive... but oh boy they do 🥲. Lots of software
are very slow to update, slow bug fixes which some can even span for a decade or two (yes that's true lmao), and
even gets abandoned because people do not contribute and just selfishly demand the maintainers without thinking
that they made this software on their free time... And that free time is not compensated well enough **_and free
time is not free_** unless you are privileged enough. These factors lead to cause some open source maintainers
to drop their project or become hostile to their users which promotes a toxic environment for both users and
maintainers. Overall, these issues affect the overall quality of the software, hence why people prefer PhotoShop 
over GIMP. Desktop environments are software as well so they are not excluded when it comes to these issues. 
There are certain instances where a certain kind of desktop environment is very hostile to users.

> Free is **not** free beer

Similar articles are listed below, *take it as a grain of salty salt*.

- [Open source enshrines the wrong privilege](https://fy.blackhats.net.au/blog/2021-03-23-open-source-enshrines-the-wrong-privilege/)
- [Open source has a people problem](https://www.infoworld.com/article/3570483/open-source-has-a-people-problem.html)

"But you just linked two?", dude I am not your nanny, formulate your own opinion by doing research and thru observations.

"But this is Linux as a desktop?" and they are related to desktop Linux adoption 🙂.

# Adoption of desktop Linux is slow because reasons

Here is my take for why it is slow.

Some people are tech-savvy enough to appreciate open source software and make Linux as their daily
driver and I kind of understand that. However, the reason the normies can't use Linux is that
the workflow, the setup, the software availability and the installation method for some software are 
unfamiliar to them.
 
Additionally, desktop Linux is more centered around seasoned developers and enthusiasts rather than 
the common people. And most people buy computers with pre-installed operating systems *which of course is **Windows** or **MacOS*** given that
Linux has a very small marketshare (around 1-2%). Those operating systems were designed 
*for those people* and it is no surprise that desktop Linux will stay as obscure for another 
decade or so *unless they use the Steam Deck*.

## Proprietary and non-Linux software

There is also an issue with using Windows software. Most of them are proprietary.
 As most software for normies are targetted mostly for the two most popular operating systems, 
Windows and MacOS, some users have to go to various workarounds just to get their favorite software 
to work e.g. running through an emulation layer or through Wine or Proton.

This can be a bit annoying for those that do not want to learn those things as they want things to get
done asap.

In my honest opinion though, this is not the fault of Linux. It's more of like "We don't want to include
Linux builds for this X software because we generate less money there" so it's a bit understandable
because capitalism. \*cough cough\*

# Is it now normie friendly then?

That kind of depends. Even the most desktop user friendly Linux distributions are not completely normie
friendly, starting from the installer to a fully installed setup. But I have to say that
it kind of is. Linux has come so far from being a developer and an enthusiast only operating system
to somewhat close to general user desktop operating system.

I think it's kind of fortunate that there are an increasing number of enthusiasts and volunteers to
create (or fork) Linux distributions and design them in a way that even those with little to no
technical knowledge can install Linux. One good example is Linux Mint, Ubuntu, and Fedora and some
Arch forks such as EndeavourOS and ArchCraft. However, the issue also arises *during* desktop usage
where users complain about installing drivers, codecs, and other stuff that requires at least
some technical know-how to fix/install/debug them. So much for an out-of-the-box experience.

Hence, I am not going to say it's fully normie friendly but there is evidence of progress. This is
my honest opinion that desktop Linux requires a lot of patience and workarounds just to make it
work sometimes.

For instance, I have to install the flatpak software for my girlfriend
since it's the fastest way to get codecs built-in to the software e.g. Firefox. My girlfriend is 
not a developer nor a programmer nor a tech enthusiast. Thus, I have to make her openSUSE
installation as sane for her as much as possible.

# FYI

Actually, *I don't use a desktop environment as much as I used to*, I always often use a tiling window manager such as
SwayWM, RiverWM, and Hyprland. For me, it can be considered a desktop linux experience (so you can only blame yourself for having bad configuration or setup). 
However, these are for enthusiast power-users that like to configure everything down to the source code (such as DWM) and our topic
is about desktop Linux for the normies so it's irrelevant.
