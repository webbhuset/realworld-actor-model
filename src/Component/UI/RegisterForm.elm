module Component.UI.RegisterForm exposing
    ( MsgIn(..)
    , MsgOut(..)
    , Model
    , component
    )

import Html exposing (Html)
import Html.Attributes as HA
import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Data.Profile.Email exposing (Email)
import Data.Profile.Username exposing (Username)
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
    , username : String
    , password : String
    , heading : String
    , haveAnAccount : String
    , haveAnAccountHref : String
    , submitButton : String
    }

type MsgIn
    = GotLabels Labels
    | GotProblems (List Problem)
    | GotCreateSuccess User


type MsgOut
    = FormWasSubmitted
        { username : Username
        , email : Email
        , password : Password
        }
    | CreateWasSuccessfull User


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
        [ Html.text "RegisterForm Component"
        ]
