# Realworld Example app

This is an implementation of the [realworld] example app, Conduit, using the
[actor model] framework in Elm.
This example aims to explain some of the design decisions made aswell
how to use the actor model for building apps.

## About Conduit

[Conduit] is a meduim.com clone, a forum application. It lets the users
post articles, comment on articles, follow other users and flag articles
as favorite. Articles can be tagged to appear in a tag feed.

Some of the high level features are:

- Filter through tagged feeds of articles.
- Post/edit articles.
- Comment on articles.
- Create user accounts.
- Follow other users.
- Authentication using JWT.

## Pages

### Home Page

- Displays the article feed and a tag cloud where you
  can filter articles.
- Displays a feed of articles posted by users you are following.

### Article View

- Lets your read the article and its comments. If you're logged in
  you can also post comments.

### User Profile

- Read info about the user. See their posted articles and who they
  are following.

### Sign In

- Login

### Sign Up

- Create an account

### New / Edit Post

- Form to create or edit articles.

### User Settings

- Change your information, email and password etc.


## Components

This is a breakdown of the app into components (actors).

### Services

Services don't have any UI and are used to abstract the backend API.

- [Article Service]
- [User Service]
- [Router]

### Site Layout

General site page layout.

- [Header]
- [Page Root]
- [Footer]

### Article

- [Create Article Form]
- [Article List]
- [Article View]
- [Article Comment View]
- [Tag cloud]

### User

- [Login Form]
- [Register Form]
- [User edit form]


## General requirements / best practices

These are some general design / architecture considerations based on my real
world experiences working with websites in production. 

> The aim here is to keep concerns and responsibilities separated to make
> the code base predictable. If there is something you can be sure of
> when working with real-world apps is that requirements change (or gets
> discovered) down the road. When that happens you should still be able
> to give precise estimates.

### Labels / Translation

No labels, placeholders or text should be hardcoded in the markup, but rather
extracted to a `Labels` record stored in each component's `Model`. This
record can be hardcoded initially.
This makes translation or changing the text easier down the road.

> Some people might think this is unnecessary or some kind of premature
> optimization since we don't have any requirement that the app should be
> translatable. At least not yet...
>
> However, the cost of doing this from the beginning is really low. If done,
> it makes adding translation capability a more predictable task since you
> know exactly which strings are needed and you don't have to search through
> a plethora of markup functions for them.

### Routes

No `href` should be hardcoded in a component. This would couple the component
to some implicit knowledge of what page / link structure the app has.

> Maybe you decide to use the fragment for routing internal links when
> developing since it makes it easier using `elm reactor`. You do something
> like `href ("#profile/" ++ username)` in your `view` functions.
> When you're about to go live some [SEO] person tells you that he
> heard that fragment routing does not work with Google and everyone panics.
>
> So... you'll have to change it...
>
> Once you're done chasing all the hrefs in your view and changing them to
> `href ("/profile/" ++ username)` someone else realizes that site must
> be placed on the `/forum` subpath due to legacy reasons... *sobbing*
>
> It is quite common that when you deploy a site into production
> the requirements on link structure changes (or rather gets discovered).


### Padding / width

Don't add any padding on a component's outermost element.

> A component should generally not know where it is placed. It might be used in
> multiple places.
> Letting the parent that is embedding the component control both width and padding
> gives more flexibility.


[SEO]: https://en.wikipedia.org/wiki/Search_engine_optimization
[realworld]: https://github.com/gothinkster/realworld
[actor model]: https://package.elm-lang.org/packages/webbhuset/elm-actor-model/latest/
[Conduit]: https://demo.realworld.io

[Login Form]: component/LoginForm.md
[Register Form]: component/RegisterForm.md
[User edit form]: component/UserEditForm.md
[Create Article Form]: component/ArticleForm.md
[Article List]: component/ArticleList.md
[Article View]: component/ArticleView.md
[Article Comment View]: component/CommentView.md
[Tag cloud]: component/Tags.md
[Header]: component/Header.md
[Page Root]: component/PageRoot.md
[Footer]: component/Footer.md
[Article Service]: component/ArticleService.md
[User Service]: component/UserService.md
[Router]: component/Router.md
