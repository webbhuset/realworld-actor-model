module Component.Service.Router exposing
    ( MsgIn(..)
    , MsgOut(..)
    , Model
    , Route(..)
    , component
    )

{-|

@docs MsgIn
@docs MsgOut

@docs component, Model
-}

import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Url exposing (Url)
import Browser.Navigation as Nav
import Data.Article.Slug exposing (Slug)
import Data.Profile.Username exposing (Username)
import Data.Href exposing (Href)


type Route
    = Home
    | NotFound
    | Login
    | Register
    | Article Slug
    | NewArticle
    | EditArticle Slug
    | Profile Username
    | ProfileFavorites Username
    | UserSettings


{-| Message In
-}
type MsgIn
    = GotUrl Url --> SendRoute
    | GotKey Nav.Key
    | ObserveRouteChanges --> SendRoute
        { replyTo : PID
        }
    | PushHref Href
    | LoadHref Href


{-| Message Out
-}
type MsgOut
    = SendRoute
        { sendTo : PID
        , route : Route
        }



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



