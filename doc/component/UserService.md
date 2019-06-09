# User Service

Service actor for the [Conduit User API](https://github.com/gothinkster/realworld/tree/master/api).

## Responsibilities

- Login / logout
- Create / update user account
- Follow / Unfollow other users

## Interfaces

```elm

type SessionEvent
    = LoggedOut
    | LoggedIn User


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


type MsgIn
    = Session_Observe --> SendSessionEvent
        { replyTo : PID
        }
    | User_Login --> SendUserResult
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
    | User_Observe --> SendUserResult
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
    | Profile_Observe --> SendProfileResult
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


type MsgOut
    = SendSessionEvent
        { sendTo : List PID
        , event : SessionEvent
        }
    | SendUserResult
        { sendTo : PID
        , user : Result Error User
        }
    | SendProfileResult
        { sendTo : PID
        , user : Result Error Profile
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

