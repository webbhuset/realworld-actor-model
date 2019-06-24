# Article Form

Form for publishing a new article or edit an existing.
Sends messages to the [article service] actor when
form is submitted.

## Responsibilities

### Basic

- Render article form

### Extra

- Preview markdown
- Autocomplete for tags

## Interfaces

```elm

import Data.Article.Slug exposing (Slug)
import Data.Article.Tag exposing (Tag)
import Data.Markdown exposing (Markdown)


type alias Labels =
    { title : String
    , description : String
    , body : String
    , tags : String
    , submitButton : String
    }


type alias Article =
    { slug : Slug
    , title : String
    , description : String
    , body : Markdown
    , tags : List Tag
    }


type alias Problem =
    { key : String
    , problem : String
    }


type MsgIn
    = GotLabels Labels
    | InitEdit Slug --> GiveMeArticleData
    | GotArticle Article
    | GotProblems (List Problem)
    | GotSuccess Article


type MsgOut
    = GiveMeArticleData Slug
    | CreateSubmitted
        { title : String
        , description : String
        , body : Markdown
        , tags : List Tag
        }
    | UpdateSubmitted
        { slug : Slug
        , title : Maybe String
        , description : Maybe String
        , body : Maybe Markdown
        , tags : Maybe (List Tag)
        }
    | CreateSuccess Slug
    | EditSuccess Slug

```

## Image

![Form screenshot](img/ArticleForm1.png)

With error messages

![Form screenshot](img/ArticleForm2.png)

## Template

```html
<div class="editor-page">
  <div class="container page">
    <div class="row">

      <div class="col-md-10 offset-md-1 col-xs-12">
        <form>
          <fieldset>
            <fieldset class="form-group">
                <input type="text" class="form-control form-control-lg" placeholder="Article Title">
            </fieldset>
            <fieldset class="form-group">
                <input type="text" class="form-control" placeholder="What's this article about?">
            </fieldset>
            <fieldset class="form-group">
                <textarea class="form-control" rows="8" placeholder="Write your article (in markdown)"></textarea>
            </fieldset>
            <fieldset class="form-group">
                <input type="text" class="form-control" placeholder="Enter tags"><div class="tag-list"></div>
            </fieldset>
            <button class="btn btn-lg pull-xs-right btn-primary" type="button">
                Publish Article
            </button>
          </fieldset>
        </form>
      </div>

    </div>
  </div>
</div>
```

[article service]: ArticleService.md
