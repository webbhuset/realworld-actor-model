module Component.Service.ArticleSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.Component as Component
import Webbhuset.PID as PID
import Html exposing (Html)
import Component.Service.Article as Article
import Data.AuthToken exposing (AuthToken(..))
import Data.Article.Slug exposing (Slug(..))


type alias Model = Article.Model
type alias MsgIn = Article.MsgIn
type alias MsgOut = Article.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.service
        { title = "Article Service"
        , component = Article.component
        , cases =
            [ test_init
            , test_article
            ]
        , stringifyMsgIn = Debug.toString
        , stringifyMsgOut = Debug.toString
        , view = view
        }



view : Model -> Html MsgIn
view model =
    Html.text "Article internals can be rendered here..."


test_init : Sandbox.TestCase MsgIn MsgOut
test_init =
    { title = "Init Auth Token"
    , desc =
    """
The Article Service needs an auth token to perform
API requests. On component init the `ObserveAuthToken`
message must be sent.
    """
    , init =
        [ Sandbox.timeout 10
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            Article.ObserveAuthToken ->
                [ Article.GotAuthToken (Just <| AuthToken "testar")
                    |> Sandbox.sendMsg
                , Sandbox.pass
                ]

            _ ->
                []
    }


test_article : Sandbox.TestCase MsgIn MsgOut
test_article =
    { title = "Load Articles"
    , desc =
    """
This test performs these steps:
- Load the article feed.
- If success, pick the first article from the feed and attempt to load it.

If the article was successfylly loaded the test passes.
    """
    , init =
        [ Article.Feed_Get
            { replyTo = PID.null
            , feed = Article.Global
            , limit = 1
            , offset = 0
            }
            |> Sandbox.sendMsg
        , Sandbox.timeout 1000
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            Article.SendFeedResult args ->
                [ if args.feed /= Article.Global then
                    Sandbox.fail "Wrong feed, should be Global"
                  else
                    case args.result of
                        Ok list ->
                            if List.length list /= 1 then
                                "Expected 1 Article, got " ++ (String.fromInt <| List.length list)
                                    |> Sandbox.fail
                            else
                                Article.Article_Get
                                    { replyTo = PID.null
                                    , slug =
                                        List.head list
                                            |> Maybe.map .slug
                                            |> Maybe.withDefault (Slug "")
                                    }
                                    |> Sandbox.sendMsg

                        Err err ->
                            "Feed result was Error: " ++ (Debug.toString err)
                                |> Sandbox.fail
                ]

            Article.SendArticleResult args ->
                [ case args.result of
                    Ok article ->
                        Sandbox.pass

                    Err err ->
                        "Article result was Error: " ++ (Debug.toString err)
                            |> Sandbox.fail
                ]

            _ ->
                []
    }


