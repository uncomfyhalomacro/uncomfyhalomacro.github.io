+++
title = "Part 4: So I am building a fullstack project"
authors = ["Soc Virnyl Estela"]
date = 2026-03-12T01:55:47Z
description = "applying builder pattern and progressing towards auth crate"
[taxonomies]
tags = ["mercado-series", "rust", "typescript", "deno", "fresh", "fullstack"]
+++

Another project update for our [mercado-series](/tags/mercado-series).

# What Was Done So Far?

I have implemented the initial JSON Web Token logic for the `auth` crate.

Using the builder pattern, I came up with the following builder struct and its
associated Claims struct to generate claims (or payload) for generating the
token.

You can see how it was used here in the [following lines of
code, alongside the JwtService struct](https://codeberg.org/uncomfyhalomacro/mercado/src/commit/5d31a5361faeda729a9b0efe7dcb24b5ca768242/crates/auth/src/jwt/service.rs#L55-L152)
from our `service.rs`.

It's flexible enough that I can basically tell it's just a wrapper around the `jsonwebtoken` crate that it is using.

```rust
    fn test_correct_signature() {
        let secret = "dumb_secret";
        let builder = ClaimsBuilder::new(5 * 60, secret.to_string());
        let claims = builder.build();
        let jwt_service = JwtService::new(secret, None);
        let token_res = jwt_service.sign(&claims);
        assert!(token_res.is_ok());
        let token = token_res.unwrap();
        assert!(jwt_service.verify(&token, None, None, None, None).is_ok());
    }
```

# Fixing Some SQL Schema and Logic

So far the `just` recipes for running the tests are problematic (and they still are)
because I find bugs here and there.

What I realise is because the migrations to create the tables should have `IF NOT EXISTS`
so it would only create the tables if they do not exist.

Another issue is the lack of variables that are related to the tests themselves. For now,
the current solution is just a band-aide. I am pretty surer there is a better way to
structure the tests like putting a separate justfile script in a separate directory.

But for now, I'll just let it be.

The next step is adding Oath2.0 logic using `openidconnect` crate to the `auth` crate.

Once that's done, I'll try implementing the `payments` crate. I believe there is already
client libraries for Payrex and Stripe payments. Not sure about Wise, I can try Wise too
since I already have a Wise card.

So far so good. No progress on the frontend yet.



