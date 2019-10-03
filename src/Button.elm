module Button exposing (default)

import Html exposing (Html, a, button)
import Html.Attributes exposing (class, classList, disabled)
import Html.Events
import Json.Decode


onClickWithPreventDefault : msg -> Html.Attribute msg
onClickWithPreventDefault message =
    Html.Events.preventDefaultOn "click"
        (Json.Decode.succeed message |> Json.Decode.map (\msg -> ( msg, True )))


internalButton : List String -> msg -> Bool -> List (Html msg) -> Html msg
internalButton classNames onClick selected children =
    button
        [ class <| String.join " " classNames
        , classList [ ( "selected", selected ) ]
        , disabled selected
        , onClickWithPreventDefault onClick
        ]
        children


default : msg -> Bool -> List (Html msg) -> Html msg
default onClick selected children =
    internalButton [ "button", "default" ] onClick selected children
