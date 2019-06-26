module Actor.UI.Tags exposing (..)

import Component.UI.Tags as Tags
import Component.Service.Article as ArticleService
import Component.Page as Page
import Webbhuset.Actor as Actor exposing (Actor, PID)
import Webbhuset.ActorSystem as System
import Msg exposing (Msg, SysMsg)
import ActorName as ActorName


actor : (Model -> process) -> Actor Tags.Model process SysMsg
actor toProcess =
    Actor.fromUI
        { wrapModel = toProcess
        , wrapMsg = Msg.UI_Tags
        , mapIn = mapIn
        , mapOut = mapOut
        }
        Tags.component


mapIn : Msg -> Maybe Tags.MsgIn
mapIn globalMsg =
    case globalMsg of
        Msg.UI_Tags msg ->
            Just msg

        Msg.Event_Tags result ->
            case result of
                Ok tags ->
                    Tags.GotTags tags
                        |> Just

                Err err ->
                    Tags.GotError err
                        |> Just
        _ ->
            Nothing


mapOut : PID -> Tags.MsgOut -> SysMsg
mapOut myPid tagsMsg =
    case tagsMsg of
        Tags.GiveMeTags ->
            ArticleService.GetTags myPid
                |> Msg.ArticleService
                |> System.sendToSingleton ActorName.ArticleService

        Tags.TagClicked tag ->
            Page.AddTagToTabs tag
                |> Msg.Page
                |> System.sendToSingleton ActorName.Page
