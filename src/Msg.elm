module Msg exposing (..)


import Component.Page as Page
import Component.Service.Article as ArticleService
import Component.UI.Tags as Tags
import Data.Article.Tag exposing (Tag)


type alias SysMsg = System.Msg ActorName Msg

type Msg
    = ArticleService ArticleService.MsgIn
    | Page Page.MsgIn
    | UI_Tags Tags.MsgIn
    | Event_Tags (Result String (List Tag))
