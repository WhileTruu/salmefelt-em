module Route exposing (..)

import Browser.Navigation as Nav
import Html
import Html.Attributes
import Url exposing (Url)
import Url.Parser exposing ((</>))



-- ROUTING


type Route
    = Home
    | Item Int Int


parser : Url.Parser.Parser (Route -> a) a
parser =
    Url.Parser.oneOf
        [ Url.Parser.map Home Url.Parser.top
        , Url.Parser.map Item (Url.Parser.s "item" </> Url.Parser.int </> Url.Parser.int)
        ]



-- PUBLIC HELPERS


href : Route -> Html.Attribute msg
href targetRoute =
    Html.Attributes.href (routeToString targetRoute)


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
    Nav.replaceUrl key (routeToString route)


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
    Nav.pushUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Url.Parser.parse parser



-- INTERNAL


routeToString : Route -> String
routeToString page =
    let
        pieces : List String
        pieces =
            case page of
                Home ->
                    []

                Item itemIndex imageIndex ->
                    [ "item", String.fromInt itemIndex, String.fromInt imageIndex ]
    in
    "#/" ++ String.join "/" pieces
