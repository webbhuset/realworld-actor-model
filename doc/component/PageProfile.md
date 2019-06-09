# Profile Page Layout

## Responsibilities

- Render profile hero
- Layout [feed] component.

## Interfaces

```elm

type alias Profile
    { image : String
    , name : String
    , bio : String
    }


type MsgIn
    = ShowProfile Username
    | GotProfile Profile
    | GotFeed PID


type MsgOut
    = ObserveProfile Username
    | SpawnFeedFor Username


```

## Image

![Profile page screenshot](img/Profile1.png)


[feed]: ArticleList.md
