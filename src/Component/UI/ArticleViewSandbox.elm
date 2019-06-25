module Component.UI.ArticleViewSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.UI.ArticleView as ArticleView
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = ArticleView.Model
type alias MsgIn = ArticleView.MsgIn
type alias MsgOut = ArticleView.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "ArticleView Component"
        , component = ArticleView.component
        , cases =
            [ test_ArticleView
            ]
        , stringifyMsgIn = Debug.toString
        , stringifyMsgOut = Debug.toString
        , wrapView = view
        }

view : Html MsgIn -> Html MsgIn
view componentHtml =
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


test_ArticleView : Sandbox.TestCase MsgIn MsgOut
test_ArticleView =
    { title = "ArticleView"
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

