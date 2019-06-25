module Component.UI.RegisterFormSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.UI.RegisterForm as RegisterForm
import Html exposing (Html)
import Html.Attributes as HA


type alias Model = RegisterForm.Model
type alias MsgIn = RegisterForm.MsgIn
type alias MsgOut = RegisterForm.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "RegisterForm Component"
        , component = RegisterForm.component
        , cases =
            [ test_RegisterForm
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


test_RegisterForm : Sandbox.TestCase MsgIn MsgOut
test_RegisterForm =
    { title = "RegisterForm"
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

