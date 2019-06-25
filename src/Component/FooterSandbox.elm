module Component.FooterSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.Footer as Footer
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = Footer.Model
type alias MsgIn = Footer.MsgIn
type alias MsgOut = Footer.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "Footer Component"
        , component = Footer.component
        , cases =
            [ test_Header
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


test_Header : Sandbox.TestCase MsgIn MsgOut
test_Header =
    { title = "Footer"
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

