module Component.Service.UserSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.Component as Component
import Webbhuset.PID as PID
import Html exposing (Html)
import Component.Service.User as User


type alias Model = User.Model
type alias MsgIn = User.MsgIn
type alias MsgOut = User.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.service
        { title = "User Service"
        , component = User.component
        , cases =
            [ test_init
            , test_NotAuthenticated
            ]
        , stringifyMsgIn = Debug.toString
        , stringifyMsgOut = Debug.toString
        , view = view
        }



view : Model -> Html MsgIn
view model =
    Html.text "User internals can be rendered here..."


test_init : Sandbox.TestCase MsgIn MsgOut
test_init =
    { title = "Observe Session events"
    , desc =
    """
When the session event is observed the current session
will be sent.
    """
    , init =
        [ User.Session_Observe
            { replyTo = PID.null
            }
            |> Sandbox.sendMsg
        , Sandbox.timeout 500
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            User.SendSessionEvent args ->
                [ if args.event == User.LoggedOut then
                    Sandbox.pass
                  else
                    Sandbox.fail "Expected a LoggedOut event"
                ]

            _ ->
                []
    }


test_NotAuthenticated : Sandbox.TestCase MsgIn MsgOut
test_NotAuthenticated =
    { title = "Authentication Required"
    , desc =
    """
Trying to access a protected API endpoint without logging in
will result in the `AuthenticationRequired` error.
    """
    , init =
        [ User.User_Observe
            { replyTo = PID.null
            }
            |> Sandbox.sendMsg
        , Sandbox.timeout 500
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            User.SendUserResult args ->
                [ case args.user of
                    Ok user ->
                        Sandbox.fail "User should not be sent with logged out."

                    Err User.AuthenticationRequired ->
                        Sandbox.pass

                    Err err ->
                        "Expected NotAuthorized error, got: " ++ (Debug.toString err)
                            |> Sandbox.fail
                ]

            _ ->
                []
    }


