# API Service

Service actor for the [Conduit Article API](https://github.com/gothinkster/realworld/tree/master/api).

## Responsibilities

- Load feeds
- CRUD articles
- Add, list, delete comments on article
- Flag / unflag articles as favorite
- List tags

## Interfaces

```elm

type alias Article =
    { slug : String
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
    { username : String
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
    = AuthTokenChanged (Maybe String)
    | Feed_Get --> SendFeedResult
        { feed : Feed
        , limit : Int
        , offset : Int
        }
    | Article_Observe --> SendArticleResult
        { replyTo : PID
        , slug : Slug
        }
    | Article_Create --> SendArticleResult
        { replyTo : PID
        , title : String
        , description : String
        , body : String
        , tagList : List String
        }
    | Article_Update --> SendArticleResult
        { replyTo : PID
        , title : Maybe String
        , description : Maybe String
        , body : Maybe String
        }
    | Article_Delete --> SendArticleResult
        { replyTo : PID
        , slug : String
        }
    | Article_ObserveComments --> SendArticleComments
        { replyTo : PID
        , slug : String
        }
    | Article_Favorite --> SendArticleResult
        { replyTo : PID
        , articleSlug : String
        }
    | Article_UnFavorite --> SendArticleResult
        { replyTo : PID
        , articleSlug : String
        }
    | Comment_Create --> SendCommentCreateResult
        { replyTo : PID
        , articleSlug : String
        , comment : String
        , clientId : Int -- Used to keep track of the results.
        }
    | Comment_Delete --> SendCommentDeleteResult
        { replyTo : PID
        , articleSlug : String
        , commentId : Int
        }
    | Tags_Observe --> SendTags
        { replyTo : PID
        }


type MsgOut
    = ObserveAuthToken
    | SendFeedResult
        { sendTo : PID
        , feed : Feed
        , total : Int
        , offset : Int
        , result : Result Error (List Article)
        }
    | SendArticleResult
        { sendTo : PID
        , articleSlug : String
        , result : Result Error Article
        }
    | SendArticleComments
        { sendTo : List PID
        , articleSlug : String
        , comments : Result Error (List Comment)
        }
    | SendCommentCreateResult
        { sendTo : PID
        , articleSlug : String
        , result : Result Error Comment
        , clientId : Int -- Will be the same value as passed in the Create message
        }
    | SendCommentDeleteResult
        { sendTo : PID
        , articleSlug : String
        , result : Result Error Int
        }
    | SendTags
        { sendTo : List PID
        , tags : Result Error (List String)
        }


type alias Problem =
    { key : String
    , problem : String
    }


type Error
    = AuthorizationRequired
    | NotAuthorized
    | ValidationError (List Problem)
    | NotFound
    | TransportError

```

