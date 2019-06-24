module Dev exposing (..)

import Url exposing (..)


urlFromModuleName : String -> Url
urlFromModuleName moduleName =
    { path = "/src/" ++ (String.replace "." "/" moduleName) ++ ".elm"
    , fragment = Nothing
    , host = "localhost"
    , port_ = Just 8000
    , protocol = Url.Http
    , query = Nothing
    }
