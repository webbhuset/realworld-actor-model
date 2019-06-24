module Component.UI.ArticleFormSandbox exposing (..)

import Webbhuset.Component.Sandbox as Sandbox exposing (SandboxProgram)
import Webbhuset.PID as PID
import Component.UI.ArticleForm as ArticleForm
import Html exposing (Html)
import Html.Attributes as HA
import Data.Article.Slug exposing (Slug(..))
import Data.Article.Tag exposing (Tag(..))
import Data.Markdown exposing (Markdown(..))


type alias Model = ArticleForm.Model
type alias MsgIn = ArticleForm.MsgIn
type alias MsgOut = ArticleForm.MsgOut


main : SandboxProgram Model MsgIn MsgOut
main =
    Sandbox.ui
        { title = "ArticleForm Component"
        , component = ArticleForm.component
        , cases =
            [ test_create
            , test_edit
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


test_create : Sandbox.TestCase MsgIn MsgOut
test_create =
    { title = "Create article"
    , desc =
    """
A create article form is empty.
    """
    , init =
        [
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            ArticleForm.CreateSubmitted data ->
                [ Sandbox.pass
                ]

            _ ->
                [ Sandbox.fail "Only CreateSubmitted makes sense."
                ]
    }


test_edit : Sandbox.TestCase MsgIn MsgOut
test_edit =
    { title = "Edit article"
    , desc =
    """
The edit article form will receive a `InitEdit` message with the
`Slug` to edit. It asks for the article data and expects it on
the `GotArticle` message.

When the form is submitted a record is sent with the changed
fields along with the article slug. Unchanged fields will contain `Nothing`
    """
    , init =
        [ ArticleForm.InitEdit (Slug "article")
            |> Sandbox.sendMsg
        ]
    , onMsgOut = \msgOut ->
        case msgOut of
            ArticleForm.GiveMeArticleData slug ->
                [ ArticleForm.GotArticle
                      { slug = slug
                      , title = "Article title"
                      , description = "Article description"
                      , body = Markdown "Article Body"
                      , tags = [ Tag "tag 1", Tag "tag 2" ]
                      }
                      |> Sandbox.sendMsg
                ]

            ArticleForm.UpdateSubmitted data ->
                [ if (Slug "article") == data.slug then
                    Sandbox.pass
                  else
                    Sandbox.fail "Wrong article slug."
                ]

            _ ->
                [
                ]
    }

