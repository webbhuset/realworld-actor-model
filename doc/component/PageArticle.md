# Article Page Layout

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
