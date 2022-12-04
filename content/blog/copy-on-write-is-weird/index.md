+++
title = "Cow is weird"
description = "strings are weirder"
date = 2024-06-24
[taxonomies]
tags = ["rust"]
+++

So I just found out something weird while learning and writing a
tutorial for Rust,

```rust
    let body: &std::borrow::Cow<'_, str> = http_req.body();
    if buf_str.contains(&**body) {
        println!("Body is same in buf");
    }
```

So I found out that `&**body` is possible because

body() -> &Cow -> deref -> Cow -> deref -> str (Size cannot be known at compile time)

therefore, add a reference -> & -> &str

OR

we can just use `.deref` and since Cow already has Deref trait, it's actually
a "double" deref like the previous explanation. However, there is a slight difference

OR

we can also just use `.as_ref` since Cow has Deref trait and the `.as_ref`
method will reference the inferred type T `self` which is String but since it's
a ref so it's &String which is then coerced to &str because of String's Deref
trait. See <https://doc.rust-lang.org/stable/src/alloc/string.rs.html#2683>
and <https://doc.rust-lang.org/stable/src/alloc/string.rs.html#2479>
