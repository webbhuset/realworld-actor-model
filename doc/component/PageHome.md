# Home Page Layout

## Responsibilities

- Render green "conduit" hero
- Layout [feed] and [tag] components in two columns

## Interfaces

```elm

type alias Labels =
    { logo : String
    , tagline : String
    }


type MsgIn
    = InitLabels Labels
    | GotFeed PID
    | GotTags PID


type MsgOut
    = SpawnFeed
    | SpawnTags

```

## Image

![Home page screenshot](img/Home1.png)


[feed]: ArticleList.md
[tag]: Tags.md
