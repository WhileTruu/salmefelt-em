module Pages.Item exposing (Msg, update, view)

import Button
import Header.View
import Html exposing (Html, div, h2, img, section, text)
import Html.Attributes exposing (alt, class, src)
import Item exposing (Item)
import Items
import Language as Language exposing (Language)
import Route exposing (Route)
import Session exposing (Session)


productImageButton : Int -> Int -> Int -> String -> Html Msg
productImageButton index selectedImageIndex imageIndex imageSrc =
    Button.default
        (ClickedChangeRoute (Route.Item index imageIndex))
        (imageIndex == selectedImageIndex)
        [ img
            [ src imageSrc
            , alt <| "button-image-" ++ String.fromInt imageIndex
            ]
            []
        ]


imageView : Int -> Int -> Item -> Html Msg
imageView index imageIndex item =
    div [ class "section" ]
        [ div [ class "buttons" ] (item.galleryImages |> List.indexedMap (productImageButton index imageIndex))
        , img
            [ src <|
                (item.galleryImages
                    |> List.indexedMap Tuple.pair
                    |> List.filter (Tuple.first >> (==) imageIndex)
                    |> List.head
                    |> Maybe.map Tuple.second
                    |> Maybe.withDefault ""
                )
            , alt item.titleEn
            ]
            []
        ]


view : Session -> Int -> Int -> List (Html Msg)
view session index imageIndex =
    [ Header.View.view session
    , section [ class "container product-view" ]
        (Items.all
            |> List.indexedMap Tuple.pair
            |> List.filter (Tuple.first >> (==) 0)
            |> List.head
            |> Maybe.map Tuple.second
            |> Maybe.map (\item -> [ imageView index imageIndex item, descriptionView session item ])
            |> Maybe.withDefault []
        )
    ]


descriptionView : Session -> Item -> Html msg
descriptionView session item =
    (case session.language of
        Language.EN ->
            { name = item.titleEn, description = item.bodyEn }

        Language.ET ->
            { name = item.titleEt, description = item.bodyEt }
    )
        |> (\{ name, description } -> div [ class "section" ] [ h2 [] [ text name ], text description ])



-- UPDATE


type Msg
    = ClickedChangeRoute Route


update : Msg -> Session -> Cmd msg
update (ClickedChangeRoute route) session =
    Route.pushUrl session.navKey route
