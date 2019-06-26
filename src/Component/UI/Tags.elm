module Component.UI.Tags exposing
    ( MsgIn(..)
    , MsgOut(..)
    , Model
    , component
    )

import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as Events
import Webbhuset.Component as Component exposing (PID)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Data.Article.Tag exposing (Tag(..))


type alias Labels =
    { title : String
    }


type MsgIn
    = GotLabels Labels
    | GotTags (List Tag)
    | GotError String
    | TagButtonClicked String


type MsgOut
    = TagClicked Tag
    | GiveMeTags


type alias Model =
    { pid : PID
    , errorMsg : Maybe String
    , tags : List Tag
    }


initModel : PID -> Model
initModel pid =
    { pid = pid
    , errorMsg = Nothing
    , tags = []
    }

--
-- Component
--

component : Component.UI Model MsgIn MsgOut
component =
    { init = init
    , update = update
    , view = view
    , onSystem = onSystem
    , subs = subs
    }


init : PID -> ( Model , List MsgOut, Cmd MsgIn )
init pid =
    ( initModel pid
    , [ GiveMeTags
      ]
    , Cmd.none
    )


onSystem : SystemEvent -> SystemEvent.Handling MsgIn
onSystem event =
    SystemEvent.default


subs : Model -> Sub MsgIn
subs model =
    Sub.none


update : MsgIn -> Model -> ( Model, List MsgOut, Cmd MsgIn )
update msgIn model =
    case msgIn of
        GotError errorMsg ->
            ( { model | errorMsg = Just errorMsg }
            , []
            , Cmd.none
            )

        GotTags tags ->
            ( { model | tags = tags }
            , []
            , Cmd.none
            )

        TagButtonClicked tag ->
            ( model
            , [ TagClicked (Tag tag)
              ]
            , Cmd.none
            )

        _ ->
            ( model
            , []
            , Cmd.none
            )


view : Model -> Html MsgIn
view model =
    Html.div
        []
        [ case model.errorMsg of
            Just errorMsg ->
                Html.div
                    [ HA.style "color" "red"
                    ]
                    [ Html.text errorMsg
                    ]

            Nothing ->
                model.tags
                    |> List.map
                        (\(Tag tag) ->
                            Html.span
                                [ HA.style "display" "inline-block"
                                , HA.style "background" "#eee"
                                , HA.style "border-radius" "16px"
                                , HA.style "border" "solid 1px black"
                                , HA.style "padding" "3px 16px"
                                , HA.style "cursor" "pointer"
                                , Events.onClick (TagButtonClicked tag)
                                ]
                                [ Html.text tag
                                ]
                        )
                    |> Html.div []
        ]
