module Pages.Item exposing (Model, Msg, toSession, update, view)

import Css
import Css.Media
import Html.Styled as HS
import Html.Styled.Attributes as HSA
import Html.Styled.Events as HSE
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


itemImageButton : Model -> Int -> String -> HS.Html Msg
itemImageButton model imageIndex imageSrc =
    HS.button
        [ HSA.css
            [ Css.height Style.buttonHeight
            , Style.button { isSelected = imageIndex == model.imageIndex }
            , Style.roundedButton
            , Css.marginRight Style.smallSpacing
            , Css.marginBottom Style.smallSpacing
            ]
        , HSE.onClick <| ClickedReplaceRoute (Route.Item model.index imageIndex)
        ]
        [ HS.img
            [ HSA.src imageSrc
            , HSA.css
                [ Css.height (Css.pct 100)
                , Css.maxHeight Style.buttonHeight
                , Css.maxWidth Style.buttonHeight
                , Css.borderRadius Style.buttonBorderRadius
                ]
            , HSA.alt <| "button-image-" ++ String.fromInt imageIndex
            ]
            []
        ]


imageView : Model -> Item -> HS.Html Msg
imageView model item =
    HS.div [ HSA.css [ itemSectionStyle ] ]
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
            , HSA.css [ Css.maxWidth (Css.pct 100) ]
            ]
            []
        ]


view : Model -> List (HS.Html Msg)
view model =
    [ headerView
    , HS.section [ HSA.css [ Style.container, Css.displayFlex ] ]
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
                HS.div [ HSA.css [ itemSectionStyle ] ]
                    [ HS.h2 [] [ HS.text name ], HS.text description ]
           )


itemSectionStyle : Css.Style
itemSectionStyle =
    Css.Media.withMedia
        [ Css.Media.all [ Css.Media.minWidth (Css.px 768) ] ]
        [ Css.firstOfType [ Css.paddingRight (Css.rem 0.4) ]
        , Css.lastOfType [ Css.paddingLeft (Css.rem 0.4) ]
        , Css.maxWidth (Css.pct 50)
        , Css.boxSizing Css.borderBox
        ]


headerView : HS.Html msg
headerView =
    HS.header
        [ HSA.css
            [ Css.marginTop Style.largeSpacing
            , Css.marginBottom Style.largeSpacing
            , Css.color Style.darkColor
            , Style.container
            ]
        ]
        [ HS.a [ Route.href Route.Home ]
            [ Logo.image [ Css.height (Css.rem 1.6), Css.width (Css.rem 10) ] ]
        ]



-- UPDATE


type Msg
    = ClickedReplaceRoute Route


update : Msg -> Model -> Cmd msg
update (ClickedReplaceRoute route) { session } =
    Route.replaceUrl session.navKey route
