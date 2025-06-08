+++
title = "First impression of the scmsync workflow of OpenBuildService"
date = 2025-06-08
authors = ["Soc Virnyl Estela"]
draft = false
[taxonomies]
tags = ["lifestyle", "tech"]
+++

Also called the Git workflow, I am quite confused of how the process works.
There is a [guide](https://opensuse.github.io/scm-staging/user_guide.html)
and even following it, I am more confused than before since there are missing
pieces and information about this workflow even though each step looks "straight-forward".

Honestly, I don't have issues if this new git workflow was communicated well
to volunteers and packagers, alike. I actually see potential in it but I
also see potential problems with it assuming this will become the main
workflow in the future.

Firstly, the lack of information on what Git config to have. When I tried it for the
first time, Git LFS needs to be enabled. What's interesting is Git LFS by nature is slow
as indexing and tracking large files can really slow down uploads and downloads of
package sources. As a volunteer living in the Philippines, in a city with at least
"okay-ish" internet, **_it took me at least 30 minutes_** to download the LFS "objects" for the
vendored tarball for rusty v8.

Secondly, after I was able to push the Git sources to my fork, I performed a PR but
here are other things that got me confused.
1. There are two git branches, `devel` vs `factory` in
<https://src.opensuse.org/javascript/rusty_v8>.
2. As mentioned in the guide, you have to make a PR to the `factory`
branch. But isn't the point of `devel` in the old workflow to attempt building
the project before pushing it to Factory as part of the checks?
3. The **scm-staging-bot** was not present even after the PR was approved.

Lastly, there should be some form of CI but maybe the build runs on OBS
through the **scm-staging-bot** 😕. But there was none present.

The new workflow is such a blocker because, for example, as of writing,
there is a need to update [deno](https://github.com/denoland/deno/) as
mentioned in [here](https://bugzilla.suse.com/show_bug.cgi?id=1244070#c4).
Knowing that, I also searched and found that there were some that
shared my frustration or confusion with the move to git workflow in
[here](https://bugzilla.suse.com/show_bug.cgi?id=1244110#c4).

Overall, this is still a developing issue, so I might update this post
after some things are cleared up? Yeah...

