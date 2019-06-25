module Component.Header exposing
    ( MsgIn(..)
    , MsgOut(..)
    , Model
    , component
    )

import Html exposing (Html)
import Html.Attributes as HA
import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Data.Href exposing (Href)
import Data.Profile.Username exposing (Username)


type alias Config route =
    { routeToHref : route -> Href
    }


type alias MenuItem route =
    { title : String
    , route : route
    }


type alias Labels =
    { logo : String
    }


type alias User =
    { username : Username
    , avatarUrl : String
    }


type MsgIn route
    = GotLabels Labels
    | GotRoute route
    | SetMenuItems (List (MenuItem route))
    | GotSession (Maybe User)


type MsgOut
    = ObserveRoute
    | ObserveSession


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

component : Component.UI Model (MsgIn route) MsgOut
component =
    { init = init
    , update = update
    , view = view
    , onSystem = onSystem
    , subs = subs
    }


init : PID -> ( Model , List MsgOut, Cmd (MsgIn route) )
init pid =
    ( initModel pid
    , []
    , Cmd.none
    )


onSystem : SystemEvent -> SystemEvent.Handling (MsgIn route)
onSystem event =
    SystemEvent.default


subs : Model -> Sub (MsgIn route)
subs model =
    Sub.none


update : (MsgIn route) -> Model -> ( Model, List MsgOut, Cmd (MsgIn route) )
update msgIn model =
    case msgIn of
        _ ->
            ( model
            , []
            , Cmd.none
            )


view : Model -> Html (MsgIn route)
view model =
    Html.div
        []
        [ Html.text "Header Component"
        ]
