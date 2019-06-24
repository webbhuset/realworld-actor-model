module Component.UI.LoginFormSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.UI.LoginForm as LoginForm
import Html exposing (Html)
import Html.Attributes as HA
import Data.Profile.Email exposing (Email(..))
import Data.Profile.Username exposing (Username(..))


type alias Model = LoginForm.Model
type alias MsgIn = LoginForm.MsgIn
type alias MsgOut = LoginForm.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "LoginForm Component"
        , component = LoginForm.component
        , cases =
            [ test_submit
            , test_success
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


test_submit : Sandbox.TestCase MsgIn MsgOut
test_submit =
    { title = "Submit Form"
    , desc =
    """
When the form is submitted using the email `fail` an error (`GotProblems`) will be
returned after 1 second, otherwise the `GotLoginSuccess` will be sent after 1 second.

The form should prevent user input while waiting for the response.
    """
    , init =
        [
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            LoginForm.FormWasSubmitted { email, password } ->
                [ if (Email "fail") == email then
                    LoginForm.GotProblems [ { key = "email or password", problem = "is not valid" } ]
                        |> Sandbox.sendMsg
                        |> Sandbox.delay 1000
                  else
                    LoginForm.GotLoginSuccess { username = Username "success" }
                        |> Sandbox.sendMsg
                        |> Sandbox.delay 1000
                ]

            _ ->
                []
    }


test_success : Sandbox.TestCase MsgIn MsgOut
test_success =
    { title = "Login Success"
    , desc =
    """
When `GotLoginSuccess` is received the component should send out
a `LoginWasSuccessfull` message.
    """
    , init =
        [ LoginForm.GotLoginSuccess { username = Username "success" }
            |> Sandbox.sendMsg
        , Sandbox.timeout 100
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            LoginForm.LoginWasSuccessfull user ->
                [ Sandbox.pass
                ]

            _ ->
                []
    }

