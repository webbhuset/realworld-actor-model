# API Service

Service actor for the [Conduit Article API](https://github.com/gothinkster/realworld/tree/master/api).
Some parts of the API requires an auth token, this is
provided by the [user service] component.


## Responsibilities

- Load feeds
- Create, Read, Update, Delete (CRUD) articles.
- Add, list, delete comments on articles.
- Flag / unflag articles as favorite.
- List tags

## Interfaces

```elm

type alias Article =
    { slug : Slug
    , title : String
    , description : String
    , body : String
    , tagList : List String
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    , favorited : Bool
    , favoritesCount : Int
    , author : Profile
    }


type alias Profile =
    { username : Username
    , bio : String
    , image : String
    , following : Bool
    }


type alias Comment =
    { id : Int
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    , body : String
    , author : Profile
    }


type Feed
    = Global
    | ByAuthorsImFollowing
    | FavoritedBy Username
    | AuthoredBy Username
    | TaggedWith Tag


type MsgIn
    = GotAuthToken (Maybe AuthToken)
    | Feed_Get --> SendFeedResult
        { replyTo : PID
        , feed : Feed
        , limit : Int
        , offset : Int
        }
    | Article_Get --> SendArticleResult
        { replyTo : PID
        , slug : Slug
        }
    | Article_Create --> SendArticleResult
        { replyTo : PID
        , title : String
        , description : String
        , body : String
        , tagList : List Tag
        }
    | Article_Update --> SendArticleResult
        { replyTo : PID
        , title : Maybe String
        , description : Maybe String
        , body : Maybe String
        }
    | Article_Delete --> SendArticleResult
        { replyTo : PID
        , slug : Slug
        }
    | Article_ObserveComments --> SendArticleComments
        { replyTo : PID
        , slug : Slug
        }
    | Article_Favorite --> SendArticleResult
        { replyTo : PID
        , slug : Slug
        }
    | Article_UnFavorite --> SendArticleResult
        { replyTo : PID
        , slug : Slug
        }
    | Comment_Create --> SendCommentCreateResult
        { replyTo : PID
        , slug : Slug
        , comment : String
        , clientId : Int -- Used to keep track of the results.
        }
    | Comment_Delete --> SendCommentDeleteResult
        { replyTo : PID
        , slug : Slug
        , commentId : Int
        }
    | Tags_Observe --> SendTags
        { replyTo : PID
        }


type MsgOut
    = ObserveAuthToken --> Expects GotAuthToken
    | SendFeedResult
        { sendTo : PID
        , feed : Feed
        , total : Int
        , offset : Int
        , result : Result Error (List Article)
        }
    | SendArticleResult
        { sendTo : PID
        , slug : Slug
        , result : Result Error Article
        }
    | SendArticleComments
        { sendTo : List PID
        , slug : Slug
        , comments : Result Error (List Comment)
        }
    | SendCommentCreateResult
        { sendTo : PID
        , slug : Slug
        , result : Result Error Comment
        , clientId : Int -- Will be the same value as passed in the Create message
        }
    | SendCommentDeleteResult
        { sendTo : PID
        , slug : Slug
        , result : Result Error Int
        }
    | SendTags
        { sendTo : List PID
        , tags : Result Error (List Tag)
        }


type alias Problem =
    { key : String
    , problem : String
    }


type Error
    = AuthenticationRequired
    | NotAuthorized
    | ValidationError (List Problem)
    | NotFound
    | TransportError

```

[user service]: UserService.md
