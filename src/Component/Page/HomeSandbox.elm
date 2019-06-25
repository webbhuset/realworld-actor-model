module Component.Page.HomeSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.Page.Home as Home
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = Home.Model
type alias MsgIn = Home.MsgIn
type alias MsgOut = Home.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.layout
        { title = "Home Component"
        , component = Home.component
        , cases =
            [ test_Home
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


test_Home : Sandbox.TestCase MsgIn MsgOut
test_Home =
    { title = "Home"
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

