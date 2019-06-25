# Footer

Site footer.

## Responsibilities

- Render attribution from markdown.

## Interfaces

```elm

import Data.Markdown exposing (Markdown)

type alias Labels =
    { logo : String
    , attribution : Markdown
    }

type MsgIn
    = GotLabels Labels


type MsgOut
    = NoOut

```

## Image

![Footer screenshot](img/Footer1.png)

## Template

```html
<div class="container">
    <a href="/" class="logo-font">conduit</a>
    <span class="attribution">
        An interactive learning project from <a href="https://thinkster.io">Thinkster</a>. Code &amp; design licensed under MIT.
    </span>
</div>
```
