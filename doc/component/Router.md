# Router Service

Parse Url

## Responsibilities

- Parse URL
- Send RouteWasChanged events

## Interfaces

```elm

type Route
    = Home
    | NotFound
    | Login
    | Register
    | Article Slug
    | NewArticle
    | EditArticle Slug
    | Profile Username
    | ProfileFavorites Username
    | UserSettings


type MsgIn
    = UrlChanged Url
    | ObserveRoute
        { replyTo : PID
        }


type MsgOut
    = ObserveUrlChanges
    | RouteWasChanged
        { sendTo : PID
        , route : Route
        }
```

