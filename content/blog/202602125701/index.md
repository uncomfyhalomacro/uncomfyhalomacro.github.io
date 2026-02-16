+++
title = "Part 2: So I am building a fullstack project"
description = "Taking it slow"
date = "2026-02-16"
updated = "2026-02-16T07:03:33Z"
authors = ["Soc Virnyl Estela"]
[taxonomies]
tags = ["mercado-series", "rust", "typescript", "deno", "fresh", "fullstack"]
+++

**Update**: I moved the project to [codeberg](https://codeberg.org/uncomfyhalomacro/mercado) because I don't want my personal projects to exist there
except for work related and other open source stuff that aren't mine (with also some exceptions of the exceptions).

Still a work in progress and I am kind of slow when planning.

# Restructure

After doing some cleanup while also doing volunteering over the weekend, I finally decided on the
final structure of the project.

<details>
<summary>Current project structure</summary>

```
.
├── backend
│   ├── Cargo.toml
│   └── src
│       └── main.rs
├── Cargo.lock
├── Cargo.toml
├── crates
│   ├── api
│   │   ├── Cargo.toml
│   │   └── src
│   │       └── lib.rs
│   ├── auth
│   │   ├── Cargo.toml
│   │   └── src
│   │       └── lib.rs
│   ├── database
│   │   ├── Cargo.toml
│   │   └── src
│   │       ├── bin
│   │       │   └── migrations
│   │       │       ├── down
│   │       │       │   └── 0001_users.rs
│   │       │       └── up
│   │       │           └── 0001_users.rs
│   │       ├── core.rs
│   │       ├── lib.rs
│   │       ├── migrations
│   │       │   ├── down
│   │       │   │   ├── mod.rs
│   │       │   │   └── users.rs
│   │       │   ├── mod.rs
│   │       │   └── up
│   │       │       ├── mod.rs
│   │       │       └── users.rs
│   │       ├── models
│   │       │   ├── mod.rs
│   │       │   ├── products.rs
│   │       │   └── users.rs
│   │       ├── prelude.rs
│   │       └── utils
│   │           └── mod.rs
│   └── payments
│       ├── Cargo.toml
│       └── src
│           └── lib.rs
├── frontend
│   ├── assets
│   │   └── styles.css
│   ├── client.ts
│   ├── components
│   │   └── Button.tsx
│   ├── deno.json
│   ├── deno.lock
│   ├── islands
│   │   └── Counter.tsx
│   ├── main.ts
│   ├── README.md
│   ├── routes
│   │   ├── _app.tsx
│   │   ├── api
│   │   │   └── [name].tsx
│   │   └── index.tsx
│   ├── static
│   │   ├── favicon.ico
│   │   └── logo.svg
│   ├── utils.ts
│   └── vite.config.ts
├── justfile
├── LICENCE
└── README.md

28 directories, 43 files
```

</details>

This project structure is still in the works but it is very effective in managing "which is which", especially after I realised
that it's more efficient to use `[workspace.dependencies]` in the virtual root manifest `Cargo.toml`.

```toml
[workspace]
members = [
        "backend",
        "crates/api",
        "crates/auth",
        "crates/database",
        "crates/payments",
]
resolver = "3"

[workspace.dependencies]
serde = { version = "1.0.228", features = ["derive"] }
serde_json = "1.0.149"
anyhow = "1.0.101"
argon2 = { version = "0.5.3", features = ["std"] }
chrono = { version = "0.4.43", features = ["serde"] }
config = "0.15.19"
deadpool-postgres = { version = "0.14.1", features = ["serde"] }
dotenvy = "0.15.7"
terminfo = "0.9.0"
tokio = { version = "1.49.0", features = ["full"] }
tokio-postgres = { version = "0.7.16", features = ["with-uuid-1", "with-serde_json-1", "with-chrono-0_4"] }
tracing = { version = "0.1.44", features = ["release_max_level_debug", "max_level_trace"] }
tracing-subscriber = { version = "0.3.22", features = ["env-filter"] }
uuid = { version = "1.21.0", features = ["serde", "v4"] }
utoipa = "5.4.0"
utoipa-axum = "0.2.0"
utoipa-swagger-ui = { version = "9.0.2", features = ["axum"] }
axum = "0.8.8"
tower-http = { version = "0.6.8", features = ["full"] }
```

It ensures that I can pin 1 version of the same dependency or dependencies across the workspace members instead of
running `cargo add` not knowing it's a version that contains a breaking change.

# On migrations

I was thinking of using SeaORM for migrations but decided against it because I want to try vanilla before tasting other
flavours, especially convenient ones like SeaORM. I was very much enticed to try SeaORM out when I read their documentation.

But for the sake of learning, I made my own migration script or more accurately, migration executables. I was able to do this
because I was planning to make the `database` crate the entry point for where database functions are called, so it's a library
and where the migration logic are defined, so it also contains binaries:

```toml
[package]
name = "database"
version = "0.1.0"
edition = "2024"

[[bin]]
name = "up_0001_users"
path = "src/bin/migrations/up/0001_users.rs"

[[bin]]
name = "down_0001_users"
path = "src/bin/migrations/down/0001_users.rs"

[dependencies]
anyhow.workspace = true
argon2.workspace = true
chrono.workspace = true
config.workspace = true
deadpool-postgres.workspace = true
dotenvy.workspace = true
serde.workspace = true
serde_json.workspace = true
terminfo.workspace = true
tokio.workspace = true
tokio-postgres.workspace = true
tracing.workspace = true
tracing-subscriber.workspace = true
uuid.workspace = true
```

Then I created a `just` recipe for `migrate-up` and `migrate-down` to test them out.

```just
migrate-up:
	cargo run --bin up_0001_users

migrate-down:
	cargo run --bin down_0001_users
```

![migrate-up result](./1.png)
![migrate-down result](./2.png)

This is just a short update. I am still currently thinking on how to structure the api and I was thinking of using tower-http for convenience
for middlewares.
