# Article Page Layout

## Responsibilities

- Layout [article view] and [comments] components in two columns

## Interfaces

```elm

type MsgIn
    = InitLabels Labels
    | GotArticle PID
    | GotComment PID


type MsgOut
    = SpawnArticle
    | SpawnComments

```

## Image

![Article page screenshot](img/PageArticle1.png)


[article view]: ArticleView.md
[comments]: CommentView.md
