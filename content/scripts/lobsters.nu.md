+++
title = "Nushell Script for Fuzzy Finding Lobster Posts"
date = 2025-06-13
authors = ["Soc Virnyl Estela"]
+++

```nu
#!/usr/bin/nu
let command_menu = if ($env.XDG_SESSION_TYPE == "wayland") { "fuzzel -d" } else { "bemenu" }
alias MENU = ^$command_menu
let sections = [ "active", "recent", "comments" ]
$env.CACHE_PATH = ("~/.cache/lobsters" | path expand)
$env.ACTIVE_RSS = ( $env.CACHE_PATH  | path join "active.xml")
$env.COMMENTS_RSS = ( $env.CACHE_PATH  | path join "comments.xml")
$env.RECENT_RSS = ( $env.CACHE_PATH  | path join "recent.xml")
if ($env.CACHE_PATH | path exists) { } else { mkdir $env.CACHE_PATH }
if (ls $env.CACHE_PATH | is-empty) or (ls $env.CACHE_PATH | get -i size | any { |s| $s == 0KB })  {
  for section in $sections {
    http get "https://lobste.rs/rss"          | save -f $env.ACTIVE_RSS
    http get "https://lobste.rs/newest.rss"   | save -f $env.RECENT_RSS
    http get "https://lobste.rs/comments.rss" | save -f $env.COMMENTS_RSS
  }
} else if (ls $env.CACHE_PATH | get -i modified | all { |i| $i < (date now) } ) { 
    http get "https://lobste.rs/rss"          | save -f $env.ACTIVE_RSS
    http get "https://lobste.rs/newest.rss"   | save -f $env.RECENT_RSS
    http get "https://lobste.rs/comments.rss" | save -f $env.COMMENTS_RSS
} else {}

let section = ($sections | to text | str trim | MENU -p "choose lobsters section>")
let active_list                 = ( open --raw $env.ACTIVE_RSS   | query xml //item | get //item )
let comment_list               = ( open --raw $env.COMMENTS_RSS | query xml //item | get //item ) 
let recent_list                 = ( open --raw $env.RECENT_RSS   | query xml //item | get //item )


if ($section | is-empty) {
   exit 1
}

# line 2 -> link to post
# line 6 -> link to comment
if ($section =~ "active") {
   let TITLES = ($active_list | each {|it| $it | lines | str trim | get 1} | uniq)
   let LINKS = ($active_list | each {|it| $it | lines | str trim | get 2})
   let POSTS = ($active_list | each {|it| $it | lines | str trim | get 6})
   let TITLE = ($TITLES | to text | MENU -p "active section list>")
   if ($TITLE | is-empty) {
      exit 1
   }
   let options = [ "link to comment" "link to title" ]
   let option = ($options | to text | str trim | MENU -p "select option>" )
   if ($option =~ "link to title") {
      for $title in ($TITLES | enumerate) {
         if $TITLE =~ $title.item {
            xdg-open $"($LINKS | get $title.index)"
         }
      }
   } else if ($option =~ "link to comment") {
     for $title in ($TITLES | enumerate) {
         if $TITLE =~ $title.item {
            xdg-open $"($POSTS | get $title.index)"
         }
     }
   }
} else if ($section =~ "comments") {
   # line to title -> 1
   # line to link comments -> 2
   let TITLES = ($comment_list | each {|it| $it | lines | str trim | get 1} | uniq)
   let TITLE = ($TITLES | to text | MENU -p "active section list>")
   if ($TITLE | is-empty) {
      exit 1
   }
   let link = ($comment_list | each {|item| $item | lines | str trim  | to text } | where ($it =~ $"($TITLE)") | each {|link| $link | lines | get 2 } | to text | MENU -p "link
   to comments>")
   xdg-open $"($link)"
} else if ($section =~ "recent") {
   let TITLES = ($recent_list | each {|it| $it | lines | str trim | get 1} | uniq)
   let LINKS = ($recent_list | each {|it| $it | lines | str trim | get 2})
   let POSTS = ($recent_list | each {|it| $it | lines | str trim | get 6})
   let TITLE = ($TITLES | to text | MENU -p "active section list>")
   if ($TITLE | is-empty) {
      exit 1
   }
   let options = [ "link to comment" "link to title" ]
   let option = ($options | to text | str trim | MENU -p "select option>" )
   if ($option =~ "link to title") {
      for $title in ($TITLES | enumerate) {
         if $TITLE =~ $title.item {
            xdg-open $"($LINKS | get $title.index)"
         }
      }
   } else if ($option =~ "link to comment") {
     for $title in ($TITLES | enumerate) {
         if $TITLE =~ $title.item {
            xdg-open $"($POSTS | get $title.index)"
         }
     }
   }
} else {
  exit 1
}
```
