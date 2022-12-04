+++
title = "I should have learned about state machines!"
authors = ["Soc Virnyl Estela"]
description = "How to think logic as a form of states"
date = 2023-09-15
tags = ["programming", "logic", "biology", "rust"]
draft = false
[taxonomies]
  tags = ["programming", "logic", "biology", "rust"]
+++

While rewriting
[OBS Service Cargo](https://github.com/openSUSE/obs-service-cargo_vendor) in Rust, I was thinking of how the logic
be represented clearly. Here and there, I thought I was done but after
reading my code, I was like, damn this looks awful. And then my mentor came
in to give me hints through his code comments in Discord and from his code
reviews on GitHub. He gave me a link of his talk for PurpleCon, a volunteer
conference for some hackers in Oceania and NZ?

Link to youtube video so you can watch as well: <https://youtu.be/VbtsQjbnNw8?si=cKcbednftxxsaIPs>


## I am a biologist too {#i-am-a-biologist-too}

The answer was right in front of me all along! I was just too
focused on the tech jargon that I got lost.

State machines exist in nature too. In many ways, cells and their
components use some form of _state_ to signify a certain kind of
action, the same way microwave ovens have a state when to turn off
e.g. if you open the lid or turn off the power, and when to turn
on e.g. when to turn the knob to the right and start the timer.

Hormones, and other forms of cell signalling tell cells what to
do. Something damaged? Just release histamines to let other immune
cells know you are damaged.  Are you high on glucose? Oh crap,
produce more insulin!

The _state_ of your body also can cause some _form of action_.
And life does this to achieve homeostasis and other forms of
biological actions such as defending against a predator or migrating
to another area to get more food.


## So how does this help me about state machines and maybe writing code? {#so-how-does-this-help-me-about-state-machines-and-maybe-writing-code}

I guess I always like think each function is a particular organelle or a cell in a
software system.

Each module is a tissue

Each set of modules interrelated of each other is an organ

And these organs form an organ system, thus, forming an organism.

Similar, if not the same, as how software is written.

**State machines** exist and we just get used to it that we forget they exist around
us.

If we think each component has a set of states, it's easier to imagine the logic of
many components of your program.


## Rust is one of the perfect language to imagine anything as states {#rust-is-one-of-the-perfect-language-to-imagine-anything-as-states}

Rust has types and enums that can be over(ab)used to think of important components
to have some set of states. I like this part of Rust where I can just slap an
enum defining a state or condition and just use it all over the code base for
things that actually make sense to have it. Even the `Option` and `Result`
types can be thought of as a _state of having something_ and a _state of
having something that does not bite you_.


## Now what? {#now-what}

This is just a short post to remind myself how powerful it is to use state machines.
