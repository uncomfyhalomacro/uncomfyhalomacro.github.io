+++
title = "How should you choose a distro?"
description = "a guide for new and old time users alike"
date = 2023-05-12
authors = ["Soc Virnyl Estela"]
[taxonomies]
tags = ["linux", "technology", "workflow"]
+++


Ever thought of what linux distribution to choose? You are not alone.

Linux (or GNU/Linux for the pedant 😛) has at least hundreds of different existing distributions. This
gives users many distributions to choose from and the freedom to use their distribution of choice. This
includes the popular distros such as Fedora, Ubuntu, openSUSE, and Linux Mint and the most obscure such
as Carbs Linux, Clear Linux, and some Arch derivative you never heard of before.

However, this can also be confusing to newcomers (or even old users) alike because your distro of choice
can really matter when it comes to community support, maintenance, and also the life of the distribution
before it f itself out of existence. This means that choosing the wrong distribution can result to
unintended consequences for you as a user for areas in e.g. security, community, and support.

This ***nearly*** happened with [Solus](https://getsol.us/) btw. The two posts summarizes what happened:

- [https://www.reddit.com/r/SolusProject/comments/ssps5j/i_no_longer_feel_safe_using_solus/](https://www.reddit.com/r/SolusProject/comments/ssps5j/i_no_longer_feel_safe_using_solus/)
- [A New Voyage - Solus Project](https://getsol.us/2023/04/18/a-new-voyage/)


Good thing it's back 😄. I don't use Solus though. But what can we learn from this btw as a user? And how
does this affect our decision to choose a distribution? Is choosing a distribution really matter?

Unfortunately, the short answer is ***yes***. You can skip btw but if you want to read more I have some
important points to take why this is so.

# Your distribution of choice really matters

It's painfully obvious that your distro of choice really matters. There are many factors to consider
when choosing a distro. Choosing the "right" distro for you is very subjective but here are the factors
you really need to consider:

- [Documentation and Wiki](#documentation-and-wiki)
- [Community](#community)
- [Software Availability](#software-availability)
- [Longevity](#longevity)

# Documentation and Wiki

Why is this first mentioned than the other sections? Because good documentation and a wiki can help both
old and new users to hop over a distro. Badly written or no documentation at all can be a reason why
certain distros will never have any new users at all. Beginner-friendly distros are "beginner friendly"
for a reason. That's because they have good documentation on how to install, use, and maintain their
system. Even hard-core "do it yourself" distros such as Arch or Gentoo are popular because they have
an informative Wiki where anyone can contribute or improve existing information.

A special mention for [FreeBSD](https://www.freebsd.org/), as it is one of my favorite non-linux 
distribution with great [documentation and manual](https://docs.freebsd.org/en/). Easy to understand and grasp.
Sadly, I really cannot daily drive it because some software work only on Linux. I do hope you try it out!

# Community

What makes a Linux (or a BSD) distribution stay alive for years and years? What keeps it afloat? And what
keeps it thriving still in the future? 

It's actually the community behind your favorite distribution.

Growing interest and usage of a distribution helps maintain motivation from both project contributors and
community members. However, incentives are actually needed to keep both the distribution and community thriving.
This is shown to be true to most *corporate* **and** *community* backed distributions such as Fedora (from RHEL),
and openSUSE (from SUSE). With no incentives such as funding and through donations, it is really hard
for a community to stay alive, and again, this nearly happened to Solus.

This is important as well in choosing your distribution because you are given the assurance to stick to that
distribution without worrying that it will someday become a dead project and a dead community.

# Software Availability

This is very self-explanatory really. Your distribution of choice may not have the software you use when you were
in another distribution. This can be fixed by helping contribute to the distribution itself by volunteering to
package the software you usually use. I don't think there should be an issue about that but it is up to you
if you have the time to do that. No one is forcing you to contribute. The idea of giving back should be encouraged 
though.

Fortunately, packaging formats such as [flatpak](https://flatpak.org/) and [snap](https://snapcraft.io) bridge the 
issues with software availability. I definitely recommend flatpak over snaps though as flatpaks are *truly 
platform-agnostic* unlike Canonical's snap 🤮. No to AppImage, I will write a blog about that soon.

# Longevity

How long does a distribution last? New distributions are born nearly every year or so but the question remains. What
keeps a distribution's existence last for decades?

The answer is very simple. Time and money. Unfortunately, free software is not actually free as you would like it to be. 
Contributors and project maintainers alike need some form of incentive for them to keep a project alive. *They gotta eat
and sleep too you know... 

Small time distributions rarely last a year or two before they become dead (insert another Arch-derivative meme here). 
These kinds of distros rarely last because there are no incentives and additionally, they are usually hobby projects or
projects that only focus on a niche.

Corporate-backed **and** community-backed distros are on the clear because they have the means and incentives to do so.
It is also why I always recommend distributions such as Fedora or openSUSE.

# Conclusion

Choosing a Linux distribution can be confusing. Sometimes joining the popular is the safest option to take. Other times, you
just want to try obscure distros just to be different. To be honest, preference is preference. Whether you like pineapple
on pizza or not, it is up to you to choose a distro. However, ignoring the factors I mentioned to choose a distribution that
you want to use daily can affect your productivity and time. If you really want to try out a distribution and test it out,
I suggest run it inside a container or virtual machine. Explore and hop around until the shoe fits 😀.



