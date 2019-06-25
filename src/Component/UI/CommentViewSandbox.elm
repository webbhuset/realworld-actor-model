module Component.UI.CommentViewSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.UI.CommentView as CommentView
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = CommentView.Model
type alias MsgIn = CommentView.MsgIn
type alias MsgOut = CommentView.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "CommentView Component"
        , component = CommentView.component
        , cases =
            [ test_CommentView
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


test_CommentView : Sandbox.TestCase MsgIn MsgOut
test_CommentView =
    { title = "CommentView"
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

