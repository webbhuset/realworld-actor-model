module Component.Page.ProfileSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.Page.Profile as Profile
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = Profile.Model
type alias MsgIn = Profile.MsgIn
type alias MsgOut = Profile.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.layout
        { title = "Profile Component"
        , component = Profile.component
        , cases =
            [ test_Profile
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


test_Profile : Sandbox.TestCase MsgIn MsgOut
test_Profile =
    { title = "Profile"
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

