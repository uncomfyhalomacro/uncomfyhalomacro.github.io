+++
title = "Part 6: So I am building a fullstack project"
date = 2026-03-23T00:19:10Z
authors = ["Soc Virnyl Estela"]
[taxonomies]
tags = ["mercado-series", "rust", "typescript", "deno", "fresh", "fullstack"]
+++

For the past few days of improving backend and experimenting axum with utoipa, I
came to a conclusion that you can offload core logic to regular functions
for reuse.

> Here is a Rust pseudocode of what I mean
>
> ```rust
> pub fn login(
> 	State(state): State<Arc<AppState>>,
> 	Json(login_details): Json<UserLoginRequest>
> ) -> Result<axum::response::Response, StatusCode> {
> 	let user = login_service(login_details).await.map_err(|err| {
> 		tracing::error!(?err);
> 		StatusCode::INTERNAL_SERVER_ERROR
> 	})?;
> 	Ok(Json(user).into_response())
> }
> ```
>
> Currently, my code smell is actually passing the functions that process form data
> to a function that process json data when I was experimenting form based logins
> with reverse-proxy and it hit me—I should separate core business logic when handling
> data. Oh well, I'll be on a huge refactor, mostly separating similar logic into a services
> module so I won't repeat myself.

I also encountered a [bug](https://github.com/juhaku/utoipa/issues/1190) in utoipa
of which is not very obvious at first. The workaround is ensuring that functions with
the same paths have different namings.

For example, if you have function in `public` and `admin` modules that handle
logins, instead of naming them both as `login`, name them separately as
`public_login` and `admin_login`. Another workaround I have was hard-coding the
paths.

I actually combined both and I think I rather do the former since I think
nesting should be reused here.

However, the latter is still problematic as it is affected by the same bug if
you accidentally rename the functions to the same name so `/admin/login` and
`/api/login` are merged as either `/admin/login` or `/api/login` whichever comes
first when generating the openapi data.

> So why talk about **form data**?

I recently came across the usage of the `formaction` attribute. It's basically `href` but
sends a form data request to the target path. Hence, I've been experimenting using `caddy`
to reverse-proxy both my frontend and backend to a common URL e.g. `https://localhost:8888`.

The downside is that, I won't be doing manual `fetch` in the frontend client, meaning,
this approach is unable to use JSON as a request body for requests in the backend.

Another downside is I am not able to use the routes that use JSON as the request body.

However, I believe that the upsides far outweigh the downsides because we can always
create a toggle for the frontend to use the JSON based routes. Another upside
is the refactor, which means it's easy to swap `Form<T>` to `JSON<T>`.

That's all for this project's update. I think I'll be taking a 1 day break from it. Too tired since
yesterday.
