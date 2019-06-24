# Page Layout

This is the page root component. It takes care of
spawning each page component when the route (url) is
changed.

## Responsibilities

- Layout header / footer / content
- Supports 3 page widths
    - Full with 12/12
    - wide 10/12
    - narrow 6/12
- Transition between pages.

## Interfaces

```elm

type PageLayout
    = FullWidth
    | Wide
    | Narrow


type MsgIn route
    = GotNewRoute route
    | GotContent
        { route : route
        , pid : PID
        , layout : PageLayout
        }
    | GotHeader PID
    | GotFooter PID


type MsgOut route
    = ObserveRoute
    | SpawnContentFor route
    | SpawnHeader
    | SpawnFooter
    | Kill PID
```

