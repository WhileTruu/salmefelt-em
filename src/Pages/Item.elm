module Pages.Item exposing (Model, toSession, view)

import Css
import Html.Styled as HS
import Html.Styled.Attributes as HSA
import Item exposing (Item)
import Items
import Language as Language exposing (Language)
import Logo
import Route exposing (Route)
import Session exposing (Session)
import Style



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


itemImageButton : Model -> Int -> String -> HS.Html msg
itemImageButton model imageIndex imageSrc =
    HS.a
        [ HSA.css
            [ Css.height (Css.rem 3)
            , Style.button { isSelected = imageIndex == model.imageIndex }
            , Style.buttonRounded
            , Css.marginRight Style.spacingSmall
            , Css.marginBottom Style.spacingSmall
            ]
        , Route.href (Route.Item model.index imageIndex)
        ]
        [ HS.img
            [ HSA.src imageSrc
            , HSA.css
                [ Css.height (Css.pct 100)
                , Css.maxHeight (Css.rem 3)
                , Css.maxWidth (Css.rem 3)
                , Css.borderRadius Style.buttonBorderRadius
                ]
            , HSA.alt <| "button-image-" ++ String.fromInt imageIndex
            ]
            []
        ]


imageView : Model -> Item -> HS.Html msg
imageView model item =
    HS.div []
        [ HS.div []
            (item.galleryImages |> List.indexedMap (itemImageButton model))
        , HS.img
            [ HSA.src <|
                (item.galleryImages
                    |> List.indexedMap Tuple.pair
                    |> List.filter (Tuple.first >> (==) model.imageIndex)
                    |> List.head
                    |> Maybe.map Tuple.second
                    |> Maybe.withDefault ""
                )
            , HSA.alt item.titleEn
            ]
            []
        ]


view : Model -> List (HS.Html msg)
view model =
    [ headerView
    , HS.section [ HSA.css [ Style.container ] ]
        (Items.all
            |> List.indexedMap Tuple.pair
            |> List.filter (Tuple.first >> (==) model.index)
            |> List.head
            |> Maybe.map Tuple.second
            |> Maybe.map (\item -> [ imageView model item, descriptionView model item ])
            |> Maybe.withDefault []
        )
    ]


descriptionView : Model -> Item -> HS.Html msg
descriptionView model item =
    (case (toSession model).language of
        Language.EN ->
            { name = item.titleEn, description = item.bodyEn }

        Language.ET ->
            { name = item.titleEt, description = item.bodyEt }
    )
        |> (\{ name, description } ->
                HS.div []
                    [ HS.h2 [] [ HS.text name ], HS.text description ]
           )


headerView : HS.Html msg
headerView =
    HS.header
        [ HSA.css
            [ Css.marginTop Style.spacingLarge
            , Css.marginBottom Style.spacingLarge
            , Css.color Style.colorDark
            , Style.container
            ]
        ]
        [ HS.a [ Route.href Route.Home ]
            [ Logo.image [ Css.height (Css.rem 1.6), Css.width (Css.rem 10) ] ]
        ]
