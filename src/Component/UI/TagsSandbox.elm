module Component.UI.TagsSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.UI.Tags as Tags
import Html exposing (Html)
import Html.Attributes as HA
import Data.Article.Tag exposing (Tag(..))


type alias Model = Tags.Model
type alias MsgIn = Tags.MsgIn
type alias MsgOut = Tags.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "Tags Component"
        , component = Tags.component
        , cases =
            [ test_tags
            , test_error
            , test_tagClicked
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


test_tags : Sandbox.TestCase MsgIn MsgOut
test_tags =
    { title = "Ask for tags"
    , desc =
    """
The component needs to ask for a list of tags when it
is initialized. The `GiveMeTags` message will be sent on init.
    """
    , init =
        [ Sandbox.timeout 10
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            Tags.GiveMeTags ->
                [ List.range 1 10
                    |> List.map (\t -> Tag <| "tag " ++ (String.fromInt t))
                    |> Tags.GotTags
                    |> Sandbox.sendMsg
                , Sandbox.pass
                ]

            _ ->
                []
    }



test_error : Sandbox.TestCase MsgIn MsgOut
test_error =
    { title = "Display Error state"
    , desc =
    """
When something goes wrong the tag component should display
the error message it received.
    """
    , init =
        [ Tags.GotError "Something went wrong"
            |> Sandbox.sendMsg
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            _ ->
                []
    }


test_tagClicked : Sandbox.TestCase MsgIn MsgOut
test_tagClicked =
    { title = "Tag Clicked"
    , desc =
    """
Click the `click me` tag to pass the test.
    """
    , init =
        [ [ "not me", "click me", "don't click me" ]
            |> List.map Tag
            |> Tags.GotTags
            |> Sandbox.sendMsg
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            Tags.TagClicked tag ->
                [ if tag == (Tag "click me") then
                    Sandbox.pass
                  else
                    Sandbox.fail "Wrong tag clicked"
                ]

            _ ->
                []
    }
