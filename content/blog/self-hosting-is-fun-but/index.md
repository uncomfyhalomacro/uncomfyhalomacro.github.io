+++
title = "Self hosting is fun but..."
date = 2024-06-02
draft = false
[taxonomies]
tags = ["life", "technology"]
+++

# Hi!

Hello there!

I have decided to start self-hosting my website! My current plans after this
is to start donating to [Codeberg][codeberg], starting July. The reason why I
decided to self-host is page load. My website, despite being a static website,
is slow to load because of Codeberg Pages. Codeberg Pages is fine actually, but
at some points in time it does a bit weird. This is probably because the data
centers are in Germany or somewhere in Europe while I am in the Philippines.

The self-hosting provider I use for here is [Linode][linode]. But I plan
to change after a month. I think I am looking at [Contabo][contabo] next.
More reasons why below.

# About Linode

Linode. Hmm. I can't give much opinions about it. This is my first time
trying out self-hosting after all.

The pricing is in my opinion, could be better? Not sure. Now that I found
out about [Contabo][contabo], I plan to ditch this instance and move over.

Documentation is actually there in Linode but most of it is either outdated
or possibly wrong? I have a lot of things I read from the docs that did not
work well for me so I read official sources instead aka **the** documentation
of the software I am going to use. They could have done it better I guess
**and they lack docs for openSUSE too** 😢.

I plan to have two compute instances in [Contabo][contabo] because I plan
to use the other instance for a database, and also self-hosting [Woodpecker
CI][woodpecker-ci]. Possibly I will add other services as well such as
- NextCloud
- VaultWarden (Bitwarden basically) or I just use password-store.
- Collabora Office

I might share one of these services to my family or friends I guess.

The reason being, for experience and it's also very fun.

# What I learned so far

## Experimenting Forgejo

It would be a waste to not use the remaining compute resources so I decided
to give [Forgejo][forgejo] a [Go][go]. :wink:

Forgejo is available now in openSUSE. Although, I am quite confused
by the systemd service but now I understand the implications for
why it was decided not to use the home directory of whatever
invokes the `forgejo` binary. This was discussed in the
https://en.opensuse.org/openSUSE:Security_Features#Systemd_hardening_effort.

Anyhow, I had a lot of hiccups configuring [Forgejo][forgejo] but I just
decided to just use whatever that systemd script has and just edit the file
to point to a custom config by running

```bash
EDITOR=kak systemctl edit --full forgejo.service
```

specifically, I edited the line containing `ExecStart=`.

> `EDITOR=kak` is so annoying. openSUSE does have a way
> to set this by adding that to `/etc/profile.local`.
> Local configs or those that are suffixed with `*.local` is
> unique to openSUSE. Users are encouraged to edit the
> local configs rather than the defaults. This is how
> I got so confused at first when trying it out the first time.
> Also, this explains why I also edit the apache config
> at a different file instead of the `httpd.conf` file. Specifically,
> by editing `/etc/sysconfig/apache2` :woozy_face:.

Anyway, the site is up at <https://forgejo.uncomfyhalomacro.pl>. Feel free
to take a look around. However, **registrations are closed** so if you want
to make an account, you are not able to unless we are friends. :warning:
If you are my friend, do keep in mind that this is experimental and still
possible that I will kill this instance. Once I get the hang of it, I will
start putting my projects to the self-hosted vm.

Another issue I have is setting the `[mailer]` configuration. Because it seems
to be not working to be honest and I am not sure why. I filed a ticket to
my mail provider if MTA is part of their service because I might be mistaken.

## Nginx

To manage redirects and subdomain URLs, I tried my hand at Nginx. I read it
as ngeenx and not like 'engine X' or like how I read Lynx.

### First Impressions

The language looks like [KDL](https://kdl.dev/). I actually do not know
what Nginx use but whatever. The syntax confuses me a lot to be honest and
I really don't like how it looks when configuring. Some of you might find
the language simple. But what really confused me a lot is doing redirects. I
guess I didn't read enough documentation 🥴.

### Certbot Integration Impressions

Certbot integration is nice. The pressing issue is when certbot rewrites
files for Nginx.  This causes a lot of confusion to me because the
rewritten configs to point to the SSL certificates are faulty and can
cause misredirects. I have to manually edit the files to be honest.

## Apache

I am not sure why but after the onslaught of trying Nginx, I decided
to use Apache.

### First Impressions

I got pampered by openSUSE because it contains templates at `/etc/apache2/vhosts.d`.
At first, I was so confused because when I read the default config at
`/etc/apache2/httpd.conf`, the documentation from Linode and other sources
conflict because openSUSE's default config has a lot of comments to discourage
the use of it. Instead, I have to edit `/etc/sysconfig/apache2` and add a
new file `/etc/apache2/httpd.conf.local`. This file is added to `/etc/sysconfig/apache2`,
specifically, `APACHE_CONF_INCLUDE_FILES`. Here is a snippet of the updated sysconfig.

```
# Here you can name files, separated by spaces, that should be Include'd from 
# httpd.conf. 
#
# This allows you to add e.g. VirtualHost statements without touching 
# /etc/apache2/httpd.conf itself, which makes upgrading easier. 
#
APACHE_CONF_INCLUDE_FILES="/etc/apache2/httpd.conf.local"
```

### Better syntax, plugins, and tooling

I am not saying that I did not have difficulty using Apache. But
as I roamed around the Internet, I just found out that it uses
utility tools that helps installs plugins. As of writing, I have
added the `filter` and `deflate` module. The latter was already
added by default but the `filter` module was not. This was
to enhance page loads (yeah I know it's a static site 🤣) but
a small speed up helps 🤪.

It's also easy to just add additional subdomains as well
in `/etc/apache2/vhosts.d`. You just have to configure if what you want
is a reverse proxy and a redirect or serve directly the directory
specifically those in `/srv/www/vhosts`.

### Certbot Integration Impressions

I am just going to say that the integration with certbot is amazing.  Even as
to correctly configure my configs. Running `certbot --apache -d mydomain.com
-d other.mydomain.com` is a breeze. It will add a new file corresponding
to the config name with `-le-ssl.conf` suffix. I just add a small modification
but so far only to the one that contains `www.mydomain.com`.

## DNS

In regards to DNS, I have some issues configuring it. I manage to learn more
about A/AAAA and CNAME records. So far, it's all good and working.

I am just surprised that I don't know how long it will really propagate. One
hiccup I made before was a mistypo of configuring spam reputation for
a mail provider I use for my custom domain. And yes, it did propagate
the domain and because of that, I have or had an ephemeral URL domain
`autoconfig.mydomain.com` which points to my atuin instance. It's gone now.

# Closing Thoughts

Self-hosting is a fun idea. Although, I might be looking at other hosting solutions
like Contabo. I heard they have a good price over ratio but I also
heard mixed reviews from different communities e.g. they lower the quality
of network bandwidth (?) but I can't seem to see what's the issue yet
so I might have to experience that myself.

[codeberg]: https://codeberg.org
[contabo]: https://contabo.com
[forgejo]: https://forgejo.org
[go]: https://go.dev/
[linode]: https://www.linode.com/
[woodpecker-ci]: https://woodpecker-ci.org
