# Tags

## Responsibilities

### Basic

- Fetch and Render tags
- When a tag is clicked, send an out msg

### Extra

- When a tag is clicked it should flash to give user feedback.
- When a loding error occur the component should display a retry button.

## Interfaces

```elm

type alias Tag =
    String


type alias Props =
    { title : String
    }


type MsgIn
    = Init Props
    | RecvTagList (List Tag)
    | RecvError String


type MsgOut
    = TagClicked String
    | GiveMeTags

```

## Image

![Tag cloud screenshot](img/Tags1.png)

## Template

```html
<div>
    <p>Popular Tags</p>
    <div class="tag-list">
        <a href="" class="tag-pill tag-default">programming</a>
        <a href="" class="tag-pill tag-default">javascript</a>
        <a href="" class="tag-pill tag-default">emberjs</a>
        <a href="" class="tag-pill tag-default">angularjs</a>
        <a href="" class="tag-pill tag-default">react</a>
        <a href="" class="tag-pill tag-default">mean</a>
        <a href="" class="tag-pill tag-default">node</a>
        <a href="" class="tag-pill tag-default">rails</a>
    </div>
</div>
```
