+++
title = "Packaging with Roast and Roast SCM"
date = 2025-06-01
[taxonomies]
tags = ["workflow","opensuse","packaging"]
+++

Hello!

In the iteration of all the changes for
[roast](https://codeberg.org/Rusty-Geckos/roast), we have finally
released a new major version, 7.x series. Although, I really
don't care much about the strictness of version numbers, this
release brings a new addition, a feature flag called `obs`. This is
[OpenBuildService](https://openbuildservice.org/) specific, and it allows it
to become an alternative to `obs-service-set_version` + `obs-service-obs_scm`,
hence, a combination of both services.

roast itself is using this to package itself to
[b-o-o](https://build.opensuse.org) using the following `_service` file
configuration.

```xml
<services>
  <service name="roast_scm" mode="manual">
     <param name="url">https://codeberg.org/Rusty-Geckos/roast</param>
     <param name="revision">v7.1.1</param>
     <param name="versionrewriteregex">v(.*)</param>
     <param name="versionrewritepattern">${1}</param>
     <param name="changesgenerate">true</param>
     <param name="changesauthor">Soc Virnyl Estela</param>
     <param name="changesemail">uncomfyhalomacro@opensuse.org</param>
  </service>
  <service name="cargo_vendor" mode="manual">
     <param name="src">roast*.tar.zst</param>
     <param name="update">true</param>
  </service>
</services>
```

which can be seen [here](https://opensuse.org/package/show/Archiving/roast).

In the future, I will release a small video tutorial on how to use `roast_scm`
for [b-o-o](https://build.opensuse.org).

Because the crate is written in Rust, I intentionally made it part of
[obs-service-cargo](https://github.com/openSUSE-Rust/obs-service-cargo/)
because of this [PR](https://github.com/openSUSE-Rust/obs-service-cargo/pull/124)
which is now merged. With this, sources can now be fetched from git sources
and vendored in just one XML file, like for `obs-service-cargo` itself:

```xml
<services>
  <service name="cargo_vendor" mode="manual">
    <param name="src">https://github.com/openSUSE-Rust/obs-service-cargo</param>
    <param name="update">true</param>
    <param name="versionrewriteregex">^v?(.*)</param>
    <param name="versionrewritepattern">${1}</param>
    <param name="changesgenerate">true</param>
    <param name="revision">master</param>
    <param name="changesauthor">Soc Virnyl Estela</param>
    <param name="changesemail">uncomfyhalomacro@opensuse.org</param>
  </service>
</services>
```

which can also be seen [here](https://build.opensuse.org/package/show/devel:languages:rust/obs-service-cargo).

Since I am one of the active Rust packagers in openSUSE, I plan to just switch
and use this new feature for vendoring auto-magically.

Well, that's just it for this short update.

