module Component.UI.UserSettingsFormSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.UI.UserSettingsForm as UserSettingsForm
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = UserSettingsForm.Model
type alias MsgIn = UserSettingsForm.MsgIn
type alias MsgOut = UserSettingsForm.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "UserSettingsForm Component"
        , component = UserSettingsForm.component
        , cases =
            [ test_UserSettingsForm
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


test_UserSettingsForm : Sandbox.TestCase MsgIn MsgOut
test_UserSettingsForm =
    { title = "UserSettingsForm"
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

