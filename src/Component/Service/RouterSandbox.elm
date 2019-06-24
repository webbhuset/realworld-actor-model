module Component.Service.RouterSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.Component as Component
import Webbhuset.PID as PID
import Html exposing (Html)
import Component.Service.Router as Router
import Url exposing (Url)
import Dev


type alias Model = Router.Model
type alias MsgIn = Router.MsgIn
type alias MsgOut = Router.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.service
        { title = "Router Service"
        , component = Router.component
        , cases =
            [ test_url
            ]
        , stringifyMsgIn = Debug.toString
        , stringifyMsgOut = Debug.toString
        , view = view
        }



view : Model -> Html MsgIn
view model =
    Html.text "Router internals can be rendered here..."


testUrl : Url
testUrl =
    Dev.urlFromModuleName "Component.Service.RouterSandbox"


test_url : Sandbox.TestCase MsgIn MsgOut
test_url =
    { title = "Router URL parse"
    , desc =
    """
# Parse URL

When an URL is received the router will parse it and
send the route to all observers.
    """
    , init =
        [ Router.ObserveRouteChanges
            { replyTo = PID.null
            }
            |> Sandbox.sendMsg
        , Router.GotUrl testUrl
            |> Sandbox.sendMsg
        , Sandbox.timeout 20
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            Router.SendRoute args ->
                [ if args.route == Router.Home then
                    Sandbox.pass
                  else
                    "Expected 'Home' route, got '" ++ (Debug.toString args.route)
                        |> Sandbox.fail
                ]
    }


