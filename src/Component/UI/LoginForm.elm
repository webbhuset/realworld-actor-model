module Component.UI.LoginForm exposing
    ( MsgIn(..)
    , MsgOut(..)
    , Model
    , Problem
    , User
    , Labels
    , component
    )

import Html exposing (Html)
import Html.Attributes as HA
import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Data.Profile.Username exposing (Username)
import Data.Profile.Email exposing (Email)
import Data.Profile.Password exposing (Password)


type alias Problem =
    { key : String
    , problem : String
    }


type alias User =
    { username : Username
    }


type alias Labels =
    { email : String
    , password : String
    , heading : String
    , needAnAccount : String
    , needAnAccountHref : String
    , submitButton : String
    }


type MsgIn
    = GotLabels Labels
    | GotProblems (List Problem)
    | GotLoginSuccess User


type MsgOut
    = FormWasSubmitted
        { email : Email
        , password : Password
        }
    | LoginWasSuccessfull User


type alias Model =
    { pid : PID
    }


initModel : PID -> Model
initModel pid =
    { pid = pid
    }

--
-- Component
--

component : Component.UI Model MsgIn MsgOut
component =
    { init = init
    , update = update
    , view = view
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


view : Model -> Html MsgIn
view model =
    Html.div
        []
        [ Html.text "Tags Component"
        ]
