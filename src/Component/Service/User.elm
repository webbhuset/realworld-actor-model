module Component.Service.User exposing
    ( MsgIn(..)
    , MsgOut(..)
    , Model
    , SessionEvent(..)
    , User
    , Profile
    , Problem
    , Error(..)
    , component
    )

{-|

@docs MsgIn
@docs MsgOut

@docs component, Model
-}

import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
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



{-| Component Model.
-}

type alias Model =
    { pid : PID
    }


initModel : PID -> Model
initModel pid =
    { pid = pid
    }


{-| Component Record
-}
component : Component.Service Model MsgIn MsgOut
component =
    { init = init
    , update = update
    , onSystem = onSystem
    , subs = subs
    }


init : PID -> ( Model , List MsgOut, Cmd MsgIn )
init pid =
    ( initModel pid
    , []
    , Cmd.none
    )


onSystem : SystemEvent -> SystemEvent.Handling MsgIn
onSystem event =
    SystemEvent.default


subs : Model -> Sub MsgIn
subs model =
    Sub.none


update : MsgIn -> Model -> ( Model, List MsgOut, Cmd MsgIn )
update msgIn model =
    case msgIn of
        _ ->
            ( model
            , []
            , Cmd.none
            )



