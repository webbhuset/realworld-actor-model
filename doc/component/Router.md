# Router Service

The router parses URLs to internal Routes
and sends them to other processes observing the
the route event.

## Responsibilities

- Parse URL
- Send Route events
- Perform `push` and `load` to browser navigation.

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
    = GotUrl Url --> SendRoute
    | GotKey Nav.Key
    | ObserveRouteChanges --> SendRoute
        { replyTo : PID
        }
    | PushHref Href
    | LoadHref Href


type MsgOut
    = SendRoute
        { sendTo : PID
        , route : Route
        }
```

