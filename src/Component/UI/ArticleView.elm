module Component.UI.ArticleView exposing
    ( MsgIn(..)
    , MsgOut(..)
    , Model
    , component
    )

import Html exposing (Html)
import Html.Attributes as HA
import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Data.Article.Slug exposing (Slug)
import Data.Markdown exposing (Markdown)
import Data.Profile.Username exposing (Username)
import Time



type alias Labels =
    { editArticle : String
    , deleteArticle : String
    , follow : String
    , unfollow : String
    , favoriteArticle : String
    }


type alias Article =
    { title : String
    , slug : Slug
    , body : Markdown
    , createdAt : Time.Posix
    , favoriteCount : Int
    , isFavorited : Bool
    , authorUsername : Username
    , authorImage : String
    , isFollowingAuthor : Bool
    }


type SessionStatus
    = LoggedOut
    | LoggedIn Username


type MsgIn
    = GotLabels Labels
    | ShowArticle Slug
    | GotSession SessionStatus
    | GotArticle Article
    | GotError String


type MsgOut
    = ObserveArticle Slug
    | ObserveSession
    | Follow Username
    | UnFollow Username
    | Favorite Slug
    | UnFavorite Slug


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
        [ Html.text "ArticleView Component"
        ]
