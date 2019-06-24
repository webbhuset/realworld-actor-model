module Component.UI.ArticleListSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.UI.ArticleList as ArticleList
import Html exposing (Html)
import Html.Attributes as HA
import Time
import Data.Article.Tag exposing (Tag(..))
import Data.Article.Slug exposing (Slug(..))
import Data.Profile.Username exposing (Username(..))
import Data.Href exposing (Href(..))


type alias Model = ArticleList.Model
type alias MsgIn = ArticleList.MsgIn TestFeed
type alias MsgOut = ArticleList.MsgOut TestFeed


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "ArticleList Component"
        , component = ArticleList.component config
        , cases =
            [ test_feed
            ]
        , stringifyMsgIn = Debug.toString
        , stringifyMsgOut = Debug.toString
        , wrapView = view
        }


config : ArticleList.Config
config =
    { articleHref = \(Slug slug) -> Href slug
    , profileHref = \(Username username)-> Href username
    }


view : Html MsgIn -> Html MsgIn
view componentHtml =
    Html.div
        [ HA.class "component"
        ]
        [ Html.node "style" [] [ Html.text css ]
        , componentHtml
        ]


article : String -> Int -> ArticleList.Article
article prefix idx =
    { title = prefix ++ " title " ++ (String.fromInt idx)
    , description = prefix ++ " description " ++ (String.fromInt idx)
    , createAt = Time.millisToPosix (1561411641000 + idx)
    , tags = [ Tag "tag 1", Tag "tag 2" ]
    , slug = Slug <| prefix ++ (String.fromInt idx)
    , favoritesCount = idx
    , favorited = if modBy 2 idx == 0 then True else False
    , authorName = Username <| "user" ++ (String.fromInt idx)
    , authorImage = "https://placehold.id/150x150"
    }


css : String
css =
    """
.component {
    font-family: sans-serif;
}
"""

type TestFeed
    = Feed1
    | Feed2


test_feed : Sandbox.TestCase MsgIn MsgOut
test_feed =
    { title = "Tabs & Feed"
    , desc =
    """
When the "tabs" are received the component will ask for
feed items. Articles for the the first tab feed is requested
initially. If there are more than 10 articles a pagination
is shown.

The first tab is also selected by default.

When the tabs are clicked the corresponding feed is requested.
    """
    , init =
        [ ArticleList.GotTabs
            [ { feed = Feed1, label = "Feed 1" }
            , { feed = Feed2, label = "Feed 2" }
            ]
            |> Sandbox.sendMsg
        , Sandbox.timeout 10
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            ArticleList.GiveMeFeedArticles args ->
                [ ArticleList.GotList
                    { articles =
                         List.range args.offset (args.offset + args.limit)
                            |> List.map (article (Debug.toString args.feed))
                    , feed = args.feed
                    , total = 200
                    , offset = args.offset
                    }
                    |> Sandbox.sendMsg
                    |> Sandbox.delay 500
                ]

            _ ->
                []
    }

