module Component.UI.CommentView exposing
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
import Data.Profile.Username exposing (Username)
import Time


type alias Comment =
    { id : Int
    , title : String
    , body : String
    , createdAt : Time.Posix
    , authorUsername : Username
    , authorImage : String
    }


type SessionStatus
    = LoggedOut
    | LoggedIn Username


type alias Labels =
    { postComment : String
    , writeCommentPlaceholder : String
    , notLoggedInMessage : String
    }


type MsgIn
    = GotLabels Labels
    | ShowCommentsForArticle Slug
    | GotSession SessionStatus
    | GotComments (List Comment)
    | CommentWasCreated
        { clientId : Int
        , comment : Comment
        }
    | CommentCreateError
        { clientId : Int
        , error : String
        }
    | CommentWasDeleted
        { commentId : Int
        }
    | CommentDeleteError
        { commentId : Int
        , error : String
        }
    | GotError String


type MsgOut
    = ObserveArticleComments Slug
    | ObserveSession
    | SubmitComment
        { articleSlug : Slug
        , body : String
        , clientId : Int
        }
    | DeleteComment
        { articleSlug : Slug
        , commentId : Int
        }


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
        [ Html.text "CommentView Component"
        ]
