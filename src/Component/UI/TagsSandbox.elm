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
            , test_longTags
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
        --, Html.node "link" [ HA.rel "stylesheet" , HA.href "//demo.productionready.io/main.css" ] []
        , componentHtml
        ]


css : String
css =
    """
.component {
    font-family: sans-serif;
    padding: 1rem;
    background: white;
}
.tags {
    background: #eee;
    padding: 8px;
}
.tags p {
    margin: 0;
}
.tags .error {
    margin-top: 0.5rem;
    color: red;
}
.tag-list {
    margin-top: 0.5rem;
}
.tag-pill {
    padding-right: 0.6em;
    padding-left: 0.6em;
    border-radius: 10rem;
}
.tag-default {
    background: #818a91;
    color: #fff !important;
    font-size: 0.8rem;
    padding-top: 0.1rem;
    padding-bottom: 0.1rem;
    white-space: nowrap;
    margin-right: 3px;
    margin-bottom: 0.2rem;
    display: inline-block;
    cursor: pointer;
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


test_longTags : Sandbox.TestCase MsgIn MsgOut
test_longTags =
    { title = "Long Tag names"
    , desc =
    """
Tags should not overflow.
    """
    , init =
        [ [ "not me asdf lorem asdf asldkfj alskdfj alksdjf alksdjf alskdfj alksdjf alksdjf alksdjf alksdfj lkadjf"
          , "other tag"
          , "tag"
          ]
            |> List.map Tag
            |> Tags.GotTags
            |> Sandbox.sendMsg
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            _ ->
                []
    }
