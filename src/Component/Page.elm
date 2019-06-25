module Component.Page exposing
    ( MsgIn(..)
    , MsgOut(..)
    , PageLayout(..)
    , Model
    , component
    )

import Html exposing (Html)
import Html.Attributes as HA
import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)



type PageLayout
    = FullWidth
    | Wide
    | Narrow


type MsgIn route
    = GotNewRoute route
    | GotContent
        { route : route
        , pid : PID
        , layout : PageLayout
        }
    | GotHeader PID
    | GotFooter PID


type MsgOut route
    = ObserveRoute
    | SpawnContentFor route
    | SpawnHeader
    | SpawnFooter
    | Kill PID


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

component : Component.Layout Model (MsgIn route) (MsgOut route) msg
component =
    { init = init
    , update = update
    , view = view
    , onSystem = onSystem
    , subs = subs
    }


init : PID -> ( Model , List (MsgOut route), Cmd (MsgIn route) )
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


update : (MsgIn route) -> Model -> ( Model, List (MsgOut route), Cmd (MsgIn route) )
update msgIn model =
    case msgIn of
        _ ->
            ( model
            , []
            , Cmd.none
            )


view : ((MsgIn route) -> msg) -> Model -> (PID -> Html msg) -> Html msg
view toSelf model renderPID =
    Html.div
        []
        [ Html.text "Page Layout"
        ]
