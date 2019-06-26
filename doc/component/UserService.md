# User Service

Service actor for the [Conduit User API](https://github.com/gothinkster/realworld/tree/master/api).
Other actors can observe the login/logout session event.

## Responsibilities

- Login / logout
- Create / update user account
- Follow / Unfollow other users
- Dispatch session events.
- Send errors

## Interfaces

```elm

import Data.Profile.Username exposing (Username)
import Data.Profile.Email exposing (Email)
import Data.Profile.Password exposing (Password)
import Data.AuthToken exposing (AuthToken)



type SessionEvent
    = LoggedOut
    | LoggedIn User


type alias User =
    { email : Email
    , token : AuthToken
    , username : Username
    , bio : String
    , image : String
    }


type alias Profile =
    { username : Username
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
        , email : Email
        , password : Password
        }
    | User_Create --> SendUserResult
        { replyTo : PID
        , username : Username
        , email : Email
        , password : Password
        }
    | User_Observe --> SendUserResult
        { replyTo : PID
        }
    | User_Update --> SendUserResult
        { replyTo : PID
        , email : Maybe Email
        , username : Maybe Username
        , password : Maybe Password
        , image : Maybe String
        , bio : Maybe String
        }
    | Profile_Observe --> SendProfileResult
        { replyTo : PID
        , username : Username
        }
    | Profile_Follow --> SendProfileResult
        { replyTo : PID
        , username : Username
        }
    | Profile_UnFollow --> SendProfileResult
        { replyTo : PID
        , username : Username
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
    = AuthenticationRequired
    | NotAuthorized
    | ValidationError (List Problem)
    | NotFound
    | TransportError

```

