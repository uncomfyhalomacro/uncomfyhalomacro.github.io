+++
title = "I fell in love with Rust"
date = 2024-04-23
draft = false
[taxonomies]
  tags = ["programming", "rust"]
+++

For quite some time, I am getting more interested in programming
languages that have good documentation, a large community and
accelerating adoption in various sectors in the industry.

<!-- more -->

Rust came to mind. I just want to write this because there are some
things in Rust that actually make sense to me as a language. I might
be guilty that I have been influenced by the hype since the start
of COVID-19, but after 3 years or so, learning the language, talking
with people, reading again the documentation - things have started
to make sense and that's why I fell in love with Rust. Here
are the whys.

# Shared Behaviours

Although, these concepts are most likely OOP, I never really appreciated OOP
in Python. Maybe because of lack of experience? Or interest in the language? Or
maybe I just hate Python.  I never said I won't be biased in this post so...

Anyway, a shared behaviour in Rust is one of the best things that makes sense to me.
These are called **traits**, and Rust actually stole this from Java's interfaces.

A trait will look like something like this

```rust
trait Fruit {
    fn has_seed() -> bool;
}

struct Apple { species: String }
struct Banana { species: String }

impl Fruit for Apple {
    fn has_seed() -> bool {
        true
    }
}

impl Fruit for Banana {
    fn has_seed() -> bool {
        false
    }
}
```

And it's a very nice addition to Rust. Whoever thought of this is a genius!

# Generics

Rust's generics are one of my favourites. It allows more flexibility and
fine-grained control. For example, there are many environments of how a
fruit is grown, be it `LaboratoryGrown`, or `Natural`.

```rust
trait Fruit<Kind> {
    fn has_seed(kind: Kind) -> bool;
}

impl Apple<LaboratoryGrown> {
    fn has_seed(kind: LaboratoryGrown) -> bool {
        false
    }
}

impl Apple<Natural> {
    fn has_seed(kind: Natural) -> bool {
        true
    }
}
```

# Some concepts that took me months to understand

## Who owns who?

At first, when I was starting with Rust, I didn't understand the ownership system
because I don't have experience writing in C or any language that involves pointers
and references heavily. However, I self-studied just enough to understand these
concepts and it's starting to makes sense! *Well to me...*

Although, I don't have years of experience writing in C, Rust babysits me
teaching me about references and pointers while also protecting me from
mistakes like using the same pointer to manipulate data, or doing stupid shit
like dropping data from the heap too early.

I am resuming to learn C a few days after this to understand footguns Rust
wants me to avoid.

## Abstractions pamper me

Rust just hides away some of the abstraction from you but also shows you
that these elisions (thanks firstyear, new word) are not actually hidden.
They're just common patterns most would take so elided so that they can
be written a little less verbose, and a little less yuck.

# Rust ecosystem

Rust has like many popular crates to choose from. The community loves to
curate and makes it way easier to getting started with Rust even for
someone like me who still considers himself not a good programmer. I still
do think that I am not good but I love to learn cool stuff.

# What actually made me fall in love with Rust

The reason is because of Rust's syntax. I know, someone may already have
expected, "oh you love Rust because it's blazingly fast!!!", but the
reality is, what got me hooked into Rust the first time was actually its
verbose syntax. The first time I tried reading it, its verbosity made me
feel comfortable like it's not hiding anything from me. Whereas, in Python,
I always feel uncomfortable... I am not sure why, even though I have some
experience with it during the Hyperskill beta test by JetBrains of which I
completed at least 90% of the beta test.

But yeah, Rust's choice of symbols for its syntax and the feeling of "I am
not hiding anything, I can tell you if you ask the right questions" is
the reason I fell in love with the language.

# BTW, I also heard you like Julia

Nah... can't hate what I haven't written for a while. I guess packaging Julia is a pain
in the ass, that much is true.
