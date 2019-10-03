module Pages.Item exposing (Model, Msg, toSession, update, view)

import Button
import Html exposing (Html, div, h2, header, img, section, text)
import Html.Attributes exposing (alt, class, src)
import Item exposing (Item)
import Items
import Language as Language exposing (Language)
import Logo
import Route exposing (Route)
import Session exposing (Session)



-- MODEL


type alias Model =
    { session : Session
    , index : Int
    , imageIndex : Int
    }


toSession : Model -> Session
toSession =
    .session



-- VIEW


itemImageButton : Model -> Int -> String -> Html Msg
itemImageButton model imageIndex imageSrc =
    Button.default
        (ClickedChangeRoute (Route.Item model.index imageIndex))
        (imageIndex == model.imageIndex)
        [ img
            [ src imageSrc
            , alt <| "button-image-" ++ String.fromInt imageIndex
            ]
            []
        ]


imageView : Model -> Item -> Html Msg
imageView model item =
    div [ class "section" ]
        [ div [ class "buttons" ]
            (item.galleryImages |> List.indexedMap (itemImageButton model))
        , img
            [ src <|
                (item.galleryImages
                    |> List.indexedMap Tuple.pair
                    |> List.filter (Tuple.first >> (==) model.imageIndex)
                    |> List.head
                    |> Maybe.map Tuple.second
                    |> Maybe.withDefault ""
                )
            , alt item.titleEn
            ]
            []
        ]


view : Model -> List (Html Msg)
view model =
    [ headerView
    , section [ class "container product-view" ]
        (Items.all
            |> List.indexedMap Tuple.pair
            |> List.filter (Tuple.first >> (==) model.index)
            |> List.head
            |> Maybe.map Tuple.second
            |> Maybe.map (\item -> [ imageView model item, descriptionView model item ])
            |> Maybe.withDefault []
        )
    ]


descriptionView : Model -> Item -> Html msg
descriptionView model item =
    (case (toSession model).language of
        Language.EN ->
            { name = item.titleEn, description = item.bodyEn }

        Language.ET ->
            { name = item.titleEt, description = item.bodyEt }
    )
        |> (\{ name, description } -> div [ class "section" ] [ h2 [] [ text name ], text description ])


headerView : Html msg
headerView =
    header [ class "header container compact" ]
        [ div [ class "logo-section compact" ]
            [ Html.a [ Route.href Route.Home ] [ Logo.image ] ]
        ]



-- UPDATE


type Msg
    = ClickedChangeRoute Route


update : Msg -> Model -> Cmd msg
update (ClickedChangeRoute route) model =
    Route.replaceUrl (toSession model).navKey route
