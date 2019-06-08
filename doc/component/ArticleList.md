# Article List

## Responsibilities

### Basic

- Show a list of articles
- Username links to user profile page
- Article title and read more links to article page

### Extra

## Interfaces

```elm

type alias Config route =
    { articleRoute : Slug -> route
    , profileRoute : Username -> route
    , routeToHref : route -> String
    }


type alias Username = String
type alias Slug = String

type alias Article =
    { title : String
    , description : String
    , createAt : Time.Posix
    , tags : List String
    , slug : Slug
    , favoritesCount : Int
    , favorited : Bool
    , authorName : Username
    , authorImage : String
    }


type alias Props =
    { readMore : String
    }


type MsgIn
    = Init Props
    | ShowArticles (List Article)
    | UpdateArticle Article


type MsgOut
    = FavoriteClicked Slug
    | TagClicked Tag

```

## Image

![Article list screenshot](img/ArticleList1.png)

## Template

```html
<div class="article-preview">
    <div class="article-meta">
        <a href="profile.html"><img src="http://i.imgur.com/Qr71crq.jpg" /></a>
        <div class="info">
            <a href="" class="author">Eric Simons</a>
            <span class="date">January 20th</span>
        </div>
        <button class="btn btn-outline-primary btn-sm pull-xs-right">
            <i class="ion-heart"></i> 29
        </button>
    </div>
    <a href="" class="preview-link">
        <h1>How to build webapps that scale</h1>
        <p>This is the description for the post.</p>
        <span>Read more...</span>
    </a>
</div>
```
