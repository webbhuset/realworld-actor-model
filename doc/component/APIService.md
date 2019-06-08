# API Service

Service actor for the [Conduit API](https://github.com/gothinkster/realworld/tree/master/api).

## Responsibilities

- Login / logout
- Create / update user account
- Follow / Unfollow other users
- CRUD articles
- Add, list, delete comments on article
- Flag / unflag articles as favorite
- List tags

## Interfaces

```elm

type alias User
    { email : String
    , token : String
    , username : String
    , bio : String
    , image : String
    }


type alias Profile =
    { username : String
    , bio : String
    , image : String
    , following : Bool
    }


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


type alias Comment =
    { id : Int
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    , body : String
    , author : Profile
    }


type MsgIn
    = User_Login --> SendUserResult
        { replyTo : PID
        , email : String
        , password : String
        }
    | User_Create --> SendUserResult
        { replyTo : PID
        , username : String
        , email : String
        , password : String
        }
    | User_Get --> SendUserResult
        { replyTo : PID
        }
    | User_Update --> SendUserResult
        { replyTo : PID
        , email : Maybe String
        , username : Maybe String
        , password : Maybe String
        , image : Maybe String
        , bio : Maybe String
        }
    | User_Feed --> SendArticleList
        { replyTo : PID
        , limit : Int
        , offset : Int
        }
    | Profile_Get --> SendProfileResult
        { replyTo : PID
        , username : String
        }
    | Profile_Follow --> SendProfileResult
        { replyTo : PID
        , username : String
        }
    | Profile_UnFollow --> SendProfileResult
        { replyTo : PID
        , username : String
        }
    | Article_List --> SendArticleList
        { replyTo : PID
        , limit : Int
        , offset : Int
        , filter_tag : Maybe Tag
        , filter_author : Maybe Username
        , filter_favorited : Maybe Username
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
    | Article_GetComments --> SendArticleComments
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
    | Comment_Create --> SendCommentResult
        { replyTo : PID
        , articleSlug : String
        , comment : String
        }
    | Comment_Delete --> SendCommentResult
        { replyTo : PID
        , articleSlug : String
        , commentId : Int
        }
    | Tags_Get --> SendTags
        { replyTo : PID
        }


type MsgOut
    = SendUserResult
        { sendTo : PID
        , user : Result Error User
        }
    = SendProfileResult
        { sendTo : PID
        , user : Result Error Profile
        }
    | SendArticleList
        { sendTo : PID
        , articles : Result Error (List Article)
        , total : Int
        }
    | SendArticleResult
        { sendTo : PID
        , articleSlug : String
        , result : Result Error Article
        }
    | SendArticleComments
        { sendTo : PID
        , articleSlug : String
        , comments : Result Error (List Comment)
        }
    | SendCommentResult
        { sendTo : PID
        , articleSlug : String
        , comment : Result Error Comment
        }
    | SendTags
        { sendTo : PID
        , tags : Result Error List String
        }


type Error
    = AuthorizationRequired
    | NotAuthorized
    | ValidationError (List ( String, String ))
    | NotFound
    | TransportError

```

