# Article Page Layout

The [page root] component only accepts one PID for
the content. This component builds the article page
by combining the [article view] and [comments] component.

## Responsibilities

- Layout [article view] and [comments] components.

## Interfaces

```elm

type MsgIn
    = ShowArticle Slug
    | GotArticleFor Slug PID
    | GotCommentFor Slug PID


type MsgOut
    = SpawnArticle Slug
    | SpawnComments Slug

```

## Image

![Article page screenshot](img/PageArticle1.png)


[article view]: ArticleView.md
[comments]: CommentView.md
[page root]: PageRoot.md
