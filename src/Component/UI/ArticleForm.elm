module Component.UI.ArticleForm exposing
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
import Data.Article.Tag exposing (Tag)
import Data.Markdown exposing (Markdown)


type alias Labels =
    { title : String
    , description : String
    , body : String
    , tags : String
    , submitButton : String
    }


type alias Article =
    { slug : Slug
    , title : String
    , description : String
    , body : Markdown
    , tags : List Tag
    }


type alias Problem =
    { key : String
    , problem : String
    }


type MsgIn
    = GotLabels Labels
    | InitEdit Slug --> GiveMeArticleData
    | GotArticle Article
    | GotProblems (List Problem)
    | GotSuccess Article


type MsgOut
    = GiveMeArticleData Slug
    | CreateSubmitted
        { title : String
        , description : String
        , body : Markdown
        , tags : List Tag
        }
    | UpdateSubmitted
        { slug : Slug
        , title : Maybe String
        , description : Maybe String
        , body : Maybe Markdown
        , tags : Maybe (List Tag)
        }
    | CreateSuccess Slug
    | EditSuccess Slug


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
        [ Html.text "Article Form Component"
        ]
