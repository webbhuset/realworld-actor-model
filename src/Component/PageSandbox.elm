module Component.PageSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.Page as Page
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = Page.Model
type alias MsgIn = Page.MsgIn Route
type alias MsgOut = Page.MsgOut Route


type Route
    = Route1
    | Route2


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.layout
        { title = "Page Component"
        , component = Page.component
        , cases =
            [ test_Page
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


test_Page : Sandbox.TestCase MsgIn MsgOut
test_Page =
    { title = "Page"
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

