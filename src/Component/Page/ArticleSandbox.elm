module Component.Page.ArticleSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.Page.Article as Article
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = Article.Model
type alias MsgIn = Article.MsgIn
type alias MsgOut = Article.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.layout
        { title = "Article Component"
        , component = Article.component
        , cases =
            [ test_Article
            ]
        , stringifyMsgIn = Debug.toString
        , stringifyMsgOut = Debug.toString
        , wrapView = view
        }

view : (MsgIn -> msg) -> Html msg -> Html msg
view toSelf componentHtml =
    Html.div
        [ HA.class "component"
        ]
        [ Html.node "style" [] [ Html.text css ]
        , componentHtml
        ]


css : String
css =
    """
.component {
    font-family: sans-serif;
}
"""


test_Article : Sandbox.TestCase MsgIn MsgOut
test_Article =
    { title = "Article"
    , desc =
    """
    """
    , init =
        [
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            _ ->
                []
    }

