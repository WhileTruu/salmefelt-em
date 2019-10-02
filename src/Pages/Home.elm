module Pages.Home exposing (Msg, update, view)

import Button
import Header.View
import Html exposing (Html, div, h2, img, p, section, text)
import Html.Attributes exposing (alt, class, src)
import Item exposing (Item)
import Items
import Language as Language exposing (Language)
import Route exposing (Route)
import Session exposing (Session)
import Translations exposing (Translations)



-- VIEW


t : Session -> (Translations -> a) -> a
t session translate =
    translate <| Translations.forLanguage session.language


intro : Session -> Html msg
intro session =
    p [ class "intro" ]
        (t session .body_text
            |> List.map text
            |> List.intersperse (Html.br [] [])
        )


getName : Language -> Item -> String
getName language item =
    case language of
        Language.EN ->
            item.titleEn

        Language.ET ->
            item.titleEt


productButton : Int -> Item -> String -> Html Msg
productButton index item path =
    Button.maxSize
        (ClickedChangeRoute (Route.Item index 0))
        False
        [ div
            [ class "square-image-container" ]
            [ img
                [ src path
                , alt <| item.titleEn ++ " " ++ String.fromInt index
                ]
                []
            ]
        ]


productList : Session -> Int -> Item -> Html Msg
productList { language } index item =
    div [ class "product" ]
        [ h2 [] [ text <| getName language item ]
        , div [ class "grid" ]
            (item.galleryImages |> List.map (productButton index item))
        ]


view : Session -> List (Html Msg)
view session =
    [ Header.View.view session
    , section
        [ class "container products" ]
        ([ intro session ]
            ++ (List.sortBy .priority Items.all
                    |> List.indexedMap (\index -> productList session index)
               )
        )
    ]



-- UPDATE


type Msg
    = ClickedChangeRoute Route


update : Msg -> Session -> Cmd msg
update (ClickedChangeRoute route) session =
    Route.pushUrl session.navKey route
