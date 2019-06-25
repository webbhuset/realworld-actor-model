module Component.HeaderSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.Header as Header
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = Header.Model
type alias MsgIn = Header.MsgIn Route
type alias MsgOut = Header.MsgOut

type Route
    = Route1
    | Route2

main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "Header Component"
        , component = Header.component
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
    { title = "Header"
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

