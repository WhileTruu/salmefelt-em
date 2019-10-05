module Pages.Home exposing (Msg, update, view)

import Css
import Html.Styled as HS
import Html.Styled.Attributes as HSA
import Html.Styled.Events as HSE
import Item exposing (Item)
import Items
import Language as Language exposing (Language)
import Logo
import Ports
import Route exposing (Route)
import Session exposing (Session)
import Style
import Translations exposing (Translations)



-- VIEW


t : Session -> (Translations -> a) -> a
t session translate =
    translate <| Translations.forLanguage session.language


intro : Session -> HS.Html msg
intro session =
    HS.p [ HSA.css [ Css.paddingBottom Style.largeSpacing ] ]
        (t session .body_text |> List.map HS.text |> List.intersperse (HS.br [] []))


getName : Language -> Item -> String
getName language item =
    case language of
        Language.EN ->
            item.titleEn

        Language.ET ->
            item.titleEt


itemHyperlink : Int -> Item -> String -> HS.Html msg
itemHyperlink index item path =
    HS.a
        [ Route.href (Route.Item index 0)
        , HSA.css
            [ Style.gridItem
            , Style.button { isSelected = False }
            , Style.roundedButton
            ]
        ]
        [ HS.div
            [ HSA.css
                [ Css.width <| Css.pct 100
                , Css.paddingBottom <| Css.pct 100
                , Css.position Css.relative
                ]
            ]
            [ HS.img
                [ HSA.src path
                , HSA.alt <| item.titleEn ++ " " ++ String.fromInt index
                , HSA.css
                    [ Css.position Css.absolute
                    , Css.maxWidth <| Css.pct 100
                    , Css.minHeight <| Css.pct 100
                    , Css.left Css.zero
                    , Css.property "object-fit" "cover"
                    , Css.borderRadius Style.buttonBorderRadius
                    ]
                ]
                []
            ]
        ]


itemList : Session -> Int -> Item -> HS.Html msg
itemList { language } index item =
    HS.div []
        [ HS.h2 [] [ HS.text <| getName language item ]
        , HS.div [ HSA.css [ Css.margin (Css.pct -1) ] ]
            (item.galleryImages |> List.map (itemHyperlink index item))
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
        [ (language |> Language.toString |> String.toLower)
            |> (\a ->
                    HS.img
                        [ HSA.css [ Css.height (Css.pct 100) ]
                        , HSA.alt <| a ++ " flag"
                        , HSA.src <| "/assets/images/" ++ a ++ ".svg"
                        ]
                        []
               )
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


facebookHyperlink : Session -> HS.Html msg
facebookHyperlink session =
    HS.a
        [ HSA.css
            [ Css.height Style.buttonHeight
            , Css.padding Css.zero
            , Css.backgroundColor <| Css.rgb 255 255 255
            , Css.marginRight Style.smallSpacing
            , Style.button { isSelected = False }
            , Style.roundedButton
            ]
        , HSA.href <| t session .links_facebook
        ]
        [ HS.img
            [ HSA.css [ Css.height Style.buttonHeight ]
            , HSA.alt "links.facebook"
            , HSA.src "/assets/images/facebook.svg"
            ]
            []
        ]


etsyHyperlink : Session -> HS.Html msg
etsyHyperlink session =
    HS.a
        [ HSA.css
            [ Css.height Style.buttonHeight
            , Css.padding Css.zero
            , Css.backgroundColor <| Css.rgb 255 255 255
            , Css.marginRight Style.smallSpacing
            , Style.button { isSelected = False }
            , Style.roundedButton
            ]
        , HSA.href <| t session .links_etsy
        ]
        [ HS.img
            [ HSA.css
                [ Css.padding4 (Css.rem 0.6) (Css.rem 0.5) (Css.rem 0.4) (Css.rem 0.5)
                , Css.height (Css.rem 2)
                ]
            , HSA.alt "links.etsy"
            , HSA.src "/assets/images/etsy.svg"
            ]
            []
        ]


instagramHyperlink : Session -> HS.Html msg
instagramHyperlink session =
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
        , HSA.href <| t session .links_instagram
        ]
        [ HS.img
            [ HSA.css [ Css.padding (Css.rem 0.25), Css.height (Css.rem 2.5) ]
            , HSA.alt "links.instagram"
            , HSA.src "/assets/images/instagram.svg"
            ]
            []
        ]


contactInformation : Session -> HS.Html msg
contactInformation session =
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
                , HSA.src "/assets/images/avatar.jpg"
                ]
                []
            ]
        , HS.div []
            [ HS.text <| t session .contact_name
            , HS.div []
                [ HS.text <| t session .phone ++ ": "
                , HS.a
                    [ HSA.css [ Style.hyperlink ]
                    , HSA.href <| "tel:" ++ t session .phonenumber
                    ]
                    [ HS.text <| t session .phonenumber ]
                ]
            , HS.div []
                [ HS.text <| t session .email ++ ": "
                , HS.a
                    [ HSA.css [ Style.hyperlink ]
                    , HSA.href <| "mailto:" ++ t session .email_address
                    ]
                    [ HS.text <| t session .email_address ]
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
            [ Logo.image []
            , languageButtons language
            ]
        , HS.h3 [] [ HS.text <| t session .header_slogan ]
        , contactInformation session
        , facebookHyperlink session
        , etsyHyperlink session
        , instagramHyperlink session
        ]


view : Session -> List (HS.Html Msg)
view session =
    [ headerView session
    , HS.section [ HSA.css [ Css.paddingBottom (Css.rem 2.25), Style.container ] ]
        (intro session
            :: (List.sortBy .priority Items.all |> List.indexedMap (itemList session))
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
