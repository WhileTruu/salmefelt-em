module Pages.Home exposing (Msg, update, view)

import Css
import Html.Styled as HS
import Html.Styled.Attributes as HSA
import Html.Styled.Events as HSE
import Images
import Item exposing (Item)
import Items
import Language as Language exposing (Language)
import Logo
import Ports
import Route exposing (Route)
import Session exposing (Session)
import Style
import Translations exposing (t)


facebookUrl : String
facebookUrl =
    "https://www.facebook.com/salmefelt"


etsyUrl : String
etsyUrl =
    "https://www.etsy.com/shop/salmefelt"


instagramUrl : String
instagramUrl =
    "https://www.instagram.com/salmefelt"



-- VIEW


intro : Session -> HS.Html msg
intro { language } =
    HS.p [ HSA.css [ Css.paddingBottom Style.largeSpacing ] ]
        [ HS.text <| t language .homePageContent ]


getName : Language -> Item -> String
getName language item =
    case language of
        Language.EN ->
            item.titleEn

        Language.ET ->
            item.titleEt


itemHyperlink : Int -> Item -> Int -> String -> HS.Html msg
itemHyperlink index item imageIndex path =
    HS.a
        [ Route.href (Route.Item index imageIndex)
        , HSA.css
            [ Style.gridItem
            , Style.button { isSelected = False }
            , Style.roundedButton
            , Css.after
                [ Css.property "content" "\"\""
                , Css.display Css.block
                , Css.paddingBottom (Css.pct 100)
                ]
            ]
        ]
        [ HS.img
            [ HSA.src path
            , HSA.alt <| item.titleEn ++ String.fromInt index
            , HSA.css
                [ Css.position Css.absolute
                , Css.width <| Css.pct 100
                , Css.height <| Css.pct 100
                , Css.property "object-fit" "cover"
                , Style.roundedButton
                ]
            ]
            []
        ]


itemView : Session -> Int -> Item -> HS.Html msg
itemView { language } index item =
    HS.div []
        [ HS.h2 [] [ HS.text <| getName language item ]
        , HS.div [ HSA.css [ Css.margin (Css.pct -1) ] ]
            (item.galleryImages |> List.indexedMap (itemHyperlink index item))
        ]


languageButton : Language -> Language -> HS.Html Msg
languageButton language selectedLanguage =
    HS.button
        [ HSA.disabled (language == selectedLanguage)
        , HSE.onClick (ToggledLanguage language)
        , HSA.css
            [ Css.height (Css.rem 1.5)
            , Css.marginLeft Style.smallSpacing
            , Style.button { isSelected = language == selectedLanguage }
            ]
        ]
        [ case language of
            Language.EN ->
                Images.en |> HS.fromUnstyled

            Language.ET ->
                Images.et |> HS.fromUnstyled
        ]


languageButtons : Language -> HS.Html Msg
languageButtons language =
    HS.div
        [ HSA.css
            [ Css.displayFlex
            , Css.flex (Css.num 1)
            , Css.justifyContent Css.flexEnd
            , Css.marginBottom Style.smallSpacing
            ]
        ]
        [ languageButton Language.EN language
        , languageButton Language.ET language
        ]


facebookHyperlink : HS.Html msg
facebookHyperlink =
    HS.a
        [ HSA.css
            [ Css.height Style.buttonHeight
            , Css.padding Css.zero
            , Css.backgroundColor <| Css.rgb 255 255 255
            , Css.marginRight Style.smallSpacing
            , Style.button { isSelected = False }
            , Style.roundedButton
            ]
        , HSA.href facebookUrl
        ]
        [ Images.facebook ]


etsyHyperlink : HS.Html msg
etsyHyperlink =
    HS.a
        [ HSA.css
            [ Css.height Style.buttonHeight
            , Css.padding Css.zero
            , Css.backgroundColor <| Css.rgb 255 255 255
            , Css.marginRight Style.smallSpacing
            , Style.button { isSelected = False }
            , Style.roundedButton
            ]
        , HSA.href etsyUrl
        ]
        [ Images.etsy ]


instagramHyperlink : HS.Html msg
instagramHyperlink =
    HS.a
        [ HSA.css
            [ Css.height Style.buttonHeight
            , Css.padding Css.zero
            , Css.property "background"
                """
                radial-gradient(
                  circle farthest-corner at 32% 106%,
                  rgb(255, 225, 125) 0%,
                  rgb(255, 205, 105) 10%,
                  rgb(250, 145, 55) 28%,
                  rgb(235, 65, 65) 42%,
                  transparent 82%
                ),
                linear-gradient(135deg, rgb(35, 75, 215) 12%, rgb(195, 60, 190) 58%)
                """
            , Style.button { isSelected = False }
            , Style.roundedButton
            ]
        , HSA.href instagramUrl
        ]
        [ Images.instagram ]


contactInformation : Session -> HS.Html msg
contactInformation { language } =
    HS.div
        [ HSA.css
            [ Css.displayFlex
            , Css.paddingBottom Style.mediumSpacing
            , Css.alignItems Css.center
            ]
        ]
        [ HS.div
            [ HSA.css
                [ Css.maxHeight (Css.rem 4)
                , Css.maxWidth (Css.rem 4)
                , Css.paddingRight Style.smallSpacing
                ]
            ]
            [ HS.img
                [ HSA.css
                    [ Css.maxHeight (Css.pct 100)
                    , Css.maxWidth (Css.pct 100)
                    , Css.borderRadius (Css.pct 50)
                    , Style.textShadow
                    ]
                , HSA.alt "avatar"
                , HSA.src Images.avatarBase64
                ]
                []
            ]
        , HS.div []
            [ HS.text <| t language .contactName
            , HS.div []
                [ HS.text <| t language .phone ++ ": "
                , HS.a
                    [ HSA.css [ Style.hyperlink ]
                    , HSA.href <| "tel:" ++ t language .phoneNumber
                    ]
                    [ HS.text <| t language .phoneNumber ]
                ]
            , HS.div []
                [ HS.text <| t language .email ++ ": "
                , HS.a
                    [ HSA.css [ Style.hyperlink ]
                    , HSA.href <| "mailto:" ++ t language .emailAddress
                    ]
                    [ HS.text <| t language .emailAddress ]
                ]
            ]
        ]


headerView : Session -> HS.Html Msg
headerView ({ language } as session) =
    HS.header
        [ HSA.css
            [ Css.paddingTop Style.largeSpacing
            , Css.paddingBottom Style.largeSpacing
            , Css.color Style.darkColor
            , Css.position Css.relative
            , Style.container
            ]
        ]
        [ HS.div
            [ HSA.css
                [ Css.displayFlex
                , Css.justifyContent Css.spaceBetween
                , Css.flexWrap Css.wrapReverse
                ]
            ]
            [ Logo.image [], languageButtons language ]
        , HS.h3 [] [ HS.text <| t language .slogan ]
        , contactInformation session
        , facebookHyperlink
        , etsyHyperlink
        , instagramHyperlink
        ]


view : Session -> List (HS.Html Msg)
view session =
    [ headerView session
    , HS.section [ HSA.css [ Css.paddingBottom (Css.rem 2.25), Style.container ] ]
        (intro session
            :: (Items.all
                    |> List.indexedMap Tuple.pair
                    |> List.sortBy (Tuple.second >> .priority)
                    |> List.map (\( index, item ) -> itemView session index item)
               )
        )
    ]



-- UPDATE


type Msg
    = ToggledLanguage Language


update : Msg -> Session -> ( Session, Cmd msg )
update (ToggledLanguage language) session =
    ( { session | language = language }
    , Ports.storeLanguage <| Language.toString language
    )
