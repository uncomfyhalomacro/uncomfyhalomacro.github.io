#!/usr/bin/just

new-blog:
    kak content/blog/$(date +%Y%m%H%M%S).md

new-blog-dir:
    #!/usr/bin/env bash
    export DIR_NAME=$(date +%Y%m%H%M%S)
    mkdir content/blog/${DIR_NAME}/
    touch content/blog/${DIR_NAME}/index.md
    kak   content/blog/${DIR_NAME}/index.md


update-theme:
    git submodule update --recursive --remote --init
    git add themes/gruvbox-v
    git commit -s -m "update theme" || true

check:
    zola check

build:
    mkdir -p templates/
    zola build

publish: update-theme build
    #!/usr/bin/env bash
    set -euxo pipefail
    cp .domains public/.domains
    cp LICENSE public/LICENCE
    pushd public/
    git init
    git remote add origin "https://${PAGES_ACCESS_TOKEN}@codeberg.org/${CI_REPO}.git"
    git add -A
    git commit -m "update site page for ${CI_COMMIT_SHA:-}"
    git push --force -u origin main

webring:
    mkdir -p templates/macros/
    echo "{% macro openring() %}" | tee templates/macros/in.html > /dev/null
    openring --verbose -n 18 -S webring-list -t in.html | tee -a templates/macros/in.html > /dev/null
    echo "{% endmacro %}" | tee -a templates/macros/in.html > /dev/null

local-publish: update-theme build
    #!/usr/bin/env bash
    set -euxo pipefail
    export CI_COMMIT_SHA="$(git rev-parse HEAD)"
    cp .domains public/.domains
    cp LICENSE public/LICENSE
    pushd public/
    git init
    git switch -c pages
    git remote add origin "git@codeberg.org:uncomfyhalomacro/pages.git"
    git add -A
    git commit -m "update site page for ${CI_COMMIT_SHA:-}"
    git push --force -u origin pages

do-all: update-theme publish

do-all-local: update-theme local-publish
