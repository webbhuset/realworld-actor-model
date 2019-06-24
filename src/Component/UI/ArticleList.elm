module Component.UI.ArticleList exposing
    ( MsgIn(..)
    , MsgOut(..)
    , Config
    , Model
    , Article
    , component
    )

import Html exposing (Html)
import Html.Attributes as HA
import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Time
import Data.Article.Tag exposing (Tag)
import Data.Article.Slug exposing (Slug)
import Data.Profile.Username exposing (Username)
import Data.Href exposing (Href)


{-| Compile time configuration (dependecy injection)
-}
type alias Config =
    { articleHref : Slug -> Href
    , profileHref : Username -> Href
    }


type alias Article =
    { title : String
    , description : String
    , createAt : Time.Posix
    , tags : List Tag
    , slug : Slug
    , favoritesCount : Int
    , favorited : Bool
    , authorName : Username
    , authorImage : String
    }


type alias Labels =
    { readMore : String
    }


type alias Tab feed =
    { feed : feed
    , label : String
    }


type MsgIn feed
    = GotLabels Labels
    | GotTabs (List (Tab feed))
    | AppendTab (Tab feed)
    | GotList
        { articles : List Article
        , feed : feed
        , total : Int
        , offset : Int
        }
    | ArticleWasChanged Article


type MsgOut feed
    = GiveMeFeedArticles
        { feed : feed
        , offset : Int
        , limit : Int
        }
    | FavoriteClicked Slug
    | TagClicked Tag


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

component : Config -> Component.UI Model (MsgIn feed) (MsgOut feed)
component config =
    { init = init
    , update = update config
    , view = view config
    , onSystem = onSystem
    , subs = subs
    }


init : PID -> ( Model , List (MsgOut feed), Cmd (MsgIn feed) )
init pid =
    ( initModel pid
    , []
    , Cmd.none
    )


onSystem : SystemEvent -> SystemEvent.Handling (MsgIn feed)
onSystem event =
    SystemEvent.default


subs : Model -> Sub (MsgIn feed)
subs model =
    Sub.none


update : Config -> (MsgIn feed) -> Model -> ( Model, List (MsgOut feed), Cmd (MsgIn feed) )
update config msgIn model =
    case msgIn of
        _ ->
            ( model
            , []
            , Cmd.none
            )


view : Config -> Model -> Html (MsgIn feed)
view config model =
    Html.div
        []
        [ Html.text "Article List Component"
        ]
