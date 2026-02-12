+++
title = "Part 1: So I am building a fullstack project"
description = "I haven't done anything like this in a while"
date = "2026-02-12"
authors = ["Soc Virnyl Estela"]
[taxonomies]
tags = ["mercado-series", "rust", "typescript", "deno", "fresh", "fullstack"]
+++

I noticed that I haven't challenged myself in building a fullstack project,
let alone I have any experience integrating third-party payment APIs such as Stripe,
and OAuth2.

So in this project, [mercado](https://github.com/uncomfyhalomacro/mercado). We will not be using
LLMs or any coding agents in this endeavour. The only time I'll be using is maybe for repetitive tasks
and for documentation.

# "This is a series"

Yes, writing this as a full blog post will take a while because I'll be scaffolding and building this project _and might
even refactor many times_. Instead, I will write a separate posts from Part 1 until I consider it completed. I call this series
as **"So I am building a fullstack project"**, also known as **Mercado Series** because it's the name of the repo and project.

## Why are you doing this?

Cause, I noticed that I've been stagnating as well? I mean, I have learnt many things from my last jobs and I think it's high time
to test out my skills again that I've gained and also challenge myself to build different projects for a **Full Stack Developer**
skill.

# Chosen technologies

In this project, I'll be using Rust for the backend and Deno+Fresh for the frontend. Why not React? Because I already have
experience writing with React. Not saying I am a master of it, but I can definitely write React and learn anything from
blogs or YouTube. However, I am quite curious about [Fresh](https://fresh.deno.dev/) and why the Deno team made it when
there are already existing solutions.

I could have used Golang, but that would be for another fullstack project series.

# Initial project structure

I am following a monorepo style with the initial project structure below (dropdown)
<details>
<summary><b>Initial project structure</b></summary>

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
│   │       └── lib.rs
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

19 directories, 30 files
```

</details>

# Defining the project

Since this project is about some webapp that can be deployed over the internet,
I need to determine the goals and intention of the project. Obviously, one is
for learning. But the rest are unknown.

So it's an ecommerce app. Therefore, we need to specify what kind of products we sell,
and what kind of sellers we have on the platform. Given the name of the project, I guess
I can think of

- fashion
  - clothing
  - shoes
  - accessories
- food
  - ingredients
  - snacks
- technology
  - computer parts
  - prebuilt desktops
  - laptops

The categories can still be extended. But for now, let's focus on those. Now I can imagine if
I were to create a database table schema for these products then it would look like the SQL below

```sql
CREATE TABLE products (
	product_id uuid PRIMARY KEY,
	category INTEGER NOT NULL,
	product_name TEXT NOT NULL,
	currency VARCHAR(3) NOT NULL,
	price NUMERIC(12, 2),
	description TEXT DEFAULT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW()
)
```

For users, we need to have some sort of categorisation as well. They can be

- sellers
- customers/subscribers
- admins
- guests

And the following tables can be created like this

```sql
CREATE TABLE users (
	id uuid PRIMARY KEY,
	category INTEGER NOT NULL,
	first_name TEXT DEFAULT NULL,
	last_name TEXT DEFAULT NULL,
	email TEXT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW()
	CONSTRAINT unique_email UNIQUE (email)
);

CREATE TABLE user_passwords (
    id uuid PRIMARY KEY,
    user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    password_hash TEXT NOT NULL,
    salt TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id)  -- ensures only one current password per user
);
```

I was thinking of using `SERIAL` or `INTEGER` for ID generation but in this small application,
I don't think it's that important. I have yet to read or understand the performance implications but
for now, I am focusing on the fact that each ID is guaranteed to be unique.

_OAuth2?_ Let's focus for now the regular login. We'll add OAuth2 later once almost everything has been finalised.

_How about usernames?_ I don't think they're important. email addresses are already unique on their own.
But I can add them if that's really an impactful change.

# Adding the database dependencies

The file at `crates/database/Cargo.toml` contains the following

```toml
[package]
name = "database"
version = "0.1.0"
edition = "2024"

[dependencies]
deadpool-postgres = { version = "0.14.1", features = ["serde"] }
tokio = { version = "1.49.0", features = ["full"] }
```

With the following initial structure

```
.
├── Cargo.toml
└── src
    ├── core.rs
    ├── lib.rs
    ├── models
    │   └── mod.rs
    ├── prelude.rs
    └── utils
        └── mod.rs

4 directories, 6 files

```

The `models` will contain the table definitions, and `utils` will contain common functions that are used around.

`core` will encapsulate essential logic, and `prelude` will be used to import all commonly imported public namespaces.

# To be continued

This post will be continued the following day or week as I have other things to attend called life. See you in the next post.




