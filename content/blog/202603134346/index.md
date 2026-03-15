+++
title = "Part 5: So I am building a fullstack project"
authors = ["Soc Virnyl Estela"]
date = 2026-03-15T07:07:34Z
description = "a new fresh experience 🍋 no pun intended"
[taxonomies]
tags = ["mercado-series", "rust", "typescript", "deno", "fresh", "fullstack"]
+++

So I made some various experimentations with Fresh and Preact.

Nothing really big but just some surface-level crap that I've been doing.

# What the Hell Even Are Signals?

I was trying to experiment with Tailwind CSS built into the
frontend template like for empty input or a status code that isn't
201 or 200, specifically for the register and login modals.

From my understanding, Signals looks similar to React's `useState`.

The usage is similar as well, but I am not sure what the differences are.

Preact describes signals as an efficient way to update UI states.

> In Preact, when a signal is passed down through a tree as props or context,
_we're only passing around references to the signal_.

This means that signals are efficient because they avoid reinitialisation and
only update the value _to the reference of the signal_.

This means we can also do some minor optimisations like avoiding rerendering
of the DOM.

At first, I didn't get it because it was an entirely new thing to me. After a bit
of reading, I think I get the idea now if combined with `useComputed`. To localise
the state into only a component, Preact suggests to use `useComputed` with `useSignal`.

For example, prior to the use of `useComputed`, I would access a value
inside a JSX/TSX and compare it to another value to render a JSX/TSX element.

```typescript
    <div>
     {statuscode.value !== 200 && (
      <a
        class="text-center rounded-md bg-white hover:bg-gray-100 text-black py-2 focus:outline-2 focus:outline-offset-2 focus:outline-white-500 "
        href="/signup"
      >
        Create Account
      </a>}
      </div>

```

After I knew about `useComputed`, I just put it inside a `useComputed` declaration

```typescript
  const showSignup = useComputed(() =>
    statuscode.value !== 200 && (
      <a
        class="text-center rounded-md bg-white hover:bg-gray-100 text-black py-2 focus:outline-2 focus:outline-offset-2 focus:outline-white-500 "
        href="/signup"
      >
        Create Account
      </a>
    )
  );
```

I won't claim that it actually does optimisations but this is what Preact said
when accessing a signal's value inside a JSX.

> In Preact, accessing a signal's .value property from within a component
automatically re-renders the component when that signal's value changes.

Accessing the signal's value in an event handler does not cause a re-render.

Once the value changes, only that part of the component updates, and not the
whole component itself.

Here is an ASMR of the login and register. Of course I will use the
template's background gradient 🤣

<video width="640" controls>
  <source src="./sc1.mp4" type="video/mp4">
</video>

# How About the Backend?

I have to adjust some changes to the backend when experimenting the frontend.

I noticed that I have to handle empty inputs as well which sends a `422 UNPROCESSABLE ENTITY` (looks
like it's called `UNPROCESSABLE CONTENT` in the <https://httpwg.org/specs/rfc9110.html#rfc.section.15.5.21> hmmmm).

Other errors or status codes returned are `401 UNAUTHORIZED`, `500 INTERNAL SERVER ERROR`, `409 CONFLICT` and `400 BAD REQUEST`.

I also made an API endpoint `/api/auth/profile` to check if the session token is still valid or not with the following code
below.

```rust
pub async fn profile(
    jar: CookieJar,
) -> anyhow::Result<(StatusCode, Json<UserInfoResponse>), StatusCode> {
    tracing::info!(?jar);
    let Some(token) = jar
        .get("session_token")
        .map(|cookie| cookie.value().to_owned())
    else {
        return Err(StatusCode::UNAUTHORIZED);
    };
    let jwt_service = JwtService::new("some-secret", None);
    let claims = jwt_service
        .verify(&token, None, None, None, None)
        .map_err(|err| {
            tracing::error!(%err);
            StatusCode::UNAUTHORIZED
        })?;

    let Some(id) = claims.sub else {
        return Err(StatusCode::UNAUTHORIZED);
    };
    let Some(email) = claims.iss else {
        return Err(StatusCode::UNAUTHORIZED);
    };

    let mut user_info = UserInfoResponse {
        id,
        email,
        roles: Vec::new(),
        first_name: None,
        last_name: None,
    };

    if let Some(extras) = &claims.extras {
        let first_name = extras.get("first_name");
        let last_name = extras.get("last_name");
        let roles_s = extras.get("roles");

        user_info.first_name = first_name.cloned();
        user_info.last_name = last_name.cloned();

        if let Some(roles) = roles_s {
            let role_str: Vec<&str> = roles.split(',').collect();
            let roles: Vec<i32> = role_str
                .iter()
                .map(|x| x.parse::<i32>())
                .collect::<Result<Vec<i32>, ParseIntError>>()
                .map_err(|err| {
                    tracing::error!(%err);
                    StatusCode::UNAUTHORIZED
                })?;
            user_info.roles = roles;
        }
    };
    tracing::info!("Passed validation ✅");

    Ok((StatusCode::OK, Json(user_info)))
}
```

I am pretty sure the logic can be reused as middleware for
handling routes that require a valid session token.

Security-wise, I would probably ask an expert or do research
because I believe if someone has the token string taken from
the cookie, it would be so problematic. The only protection it
has is the signature verification of which I am unsure if it
is very protective enough.

That's all. I'll continue building the database crate again
for the products schema.
