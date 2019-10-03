module Pages.Home exposing (Msg, update, view)

import Button
import Css
import Css.Media
import Html
import Html.Styled
import Html.Styled.Attributes
import Html.Styled.Events
import Item exposing (Item)
import Items
import Language as Language exposing (Language)
import Logo
import Route exposing (Route)
import Session exposing (Session)
import Svg.Styled
import Translations exposing (Translations)



-- VIEW


t : Session -> (Translations -> a) -> a
t session translate =
    translate <| Translations.forLanguage session.language


intro : Session -> Html.Styled.Html msg
intro session =
    Html.Styled.p [ Html.Styled.Attributes.class "intro" ]
        (t session .body_text
            |> List.map Html.Styled.text
            |> List.intersperse (Html.Styled.br [] [])
        )


getName : Language -> Item -> String
getName language item =
    case language of
        Language.EN ->
            item.titleEn

        Language.ET ->
            item.titleEt


productButton : Int -> Item -> String -> Html.Styled.Html msg
productButton index item path =
    Html.Styled.a
        [ Html.Styled.Attributes.class "button max-size"
        , Route.styledHref (Route.Item index 0)
        ]
        [ Html.Styled.div
            [ Html.Styled.Attributes.class "square-image-container" ]
            [ Html.Styled.img
                [ Html.Styled.Attributes.src path
                , Html.Styled.Attributes.alt <| item.titleEn ++ " " ++ String.fromInt index
                ]
                []
            ]
        ]


productList : Session -> Int -> Item -> Html.Styled.Html msg
productList { language } index item =
    Html.Styled.div [ Html.Styled.Attributes.class "product" ]
        [ Html.Styled.h2 [] [ Html.Styled.text <| getName language item ]
        , Html.Styled.div [ Html.Styled.Attributes.class "grid" ]
            (item.galleryImages |> List.map (productButton index item))
        ]


languageButton : Language -> Language -> Html.Styled.Html Msg
languageButton language selectedLanguage =
    Html.Styled.button
        [ Html.Styled.Attributes.class <| "button small"
        , Html.Styled.Attributes.classList [ ( "selected", language == selectedLanguage ) ]
        , Html.Styled.Attributes.disabled (language == selectedLanguage)
        , Html.Styled.Events.onClick (ToggledLanguage language)
        ]
        [ Html.Styled.img
            ((language |> Language.toString |> String.toLower)
                |> (\a ->
                        [ Html.Styled.Attributes.alt <| a ++ " flag"
                        , Html.Styled.Attributes.src <| "/assets/images/" ++ a ++ ".svg"
                        ]
                   )
            )
            []
        ]


languageButtons : Language -> Html.Styled.Html Msg
languageButtons language =
    Html.Styled.div [ Html.Styled.Attributes.class "language-buttons" ]
        [ languageButton Language.EN language
        , languageButton Language.ET language
        ]


externalLinks : Session -> Html.Styled.Html msg
externalLinks session =
    let
        link : { className : String, url : String } -> List (Html.Styled.Html msg) -> Html.Styled.Html msg
        link { className, url } =
            Html.Styled.a
                [ Html.Styled.Attributes.class <| "button default " ++ className
                , Html.Styled.Attributes.href url
                ]
    in
    Html.Styled.div [ Html.Styled.Attributes.class "external-links" ]
        [ link { className = "facebook", url = t session .links_facebook }
            [ Html.Styled.img
                [ Html.Styled.Attributes.alt "links.facebook"
                , Html.Styled.Attributes.src "/assets/images/facebook.svg"
                ]
                []
            ]
        , link { className = "etsy", url = t session .links_etsy }
            [ Html.Styled.img
                [ Html.Styled.Attributes.alt "links.etsy"
                , Html.Styled.Attributes.src "/assets/images/etsy.svg"
                ]
                []
            ]
        , link { className = "instagram", url = t session .links_instagram }
            [ Html.Styled.img
                [ Html.Styled.Attributes.alt "link.instagram"
                , Html.Styled.Attributes.src "/assets/images/instagram.svg"
                ]
                []
            ]
        ]


contactInformation : Session -> Html.Styled.Html msg
contactInformation session =
    Html.Styled.div [ Html.Styled.Attributes.class "contact-information" ]
        [ Html.Styled.div [ Html.Styled.Attributes.class "avatar" ]
            [ Html.Styled.img
                [ Html.Styled.Attributes.alt "avatar"
                , Html.Styled.Attributes.src "/assets/images/avatar.jpg"
                ]
                []
            ]
        , Html.Styled.div []
            [ Html.Styled.text <| t session .contact_name
            , Html.Styled.div []
                [ Html.Styled.text <| t session .phone ++ ": "
                , Html.Styled.a
                    [ Html.Styled.Attributes.class "link link--dark"
                    , Html.Styled.Attributes.href <| "tel:" ++ t session .phonenumber
                    ]
                    [ Html.Styled.text <| t session .phonenumber ]
                ]
            , Html.Styled.div []
                [ Html.Styled.text <| t session .email ++ ": "
                , Html.Styled.a
                    [ Html.Styled.Attributes.class "link link--dark", Html.Styled.Attributes.href <| "mailto:" ++ t session .email_address ]
                    [ Html.Styled.text <| t session .email_address ]
                ]
            ]
        ]


headerView : Session -> Html.Styled.Html Msg
headerView ({ language } as session) =
    Html.Styled.header [ Html.Styled.Attributes.class "header", Html.Styled.Attributes.css containerStyles ]
        [ Html.Styled.div [ Html.Styled.Attributes.class "logo-section" ]
            [ Svg.Styled.fromUnstyled Logo.image, languageButtons language ]
        , Html.Styled.h3 [] [ Html.Styled.text <| t session .header_slogan ]
        , contactInformation session
        , externalLinks session
        ]


view : Session -> List (Html.Html Msg)
view session =
    [ headerView session
    , Html.Styled.section
        [ Html.Styled.Attributes.css
            (Css.paddingBottom (Css.rem 2.25) :: containerStyles)
        ]
        (intro session
            :: (List.sortBy .priority Items.all |> List.indexedMap (productList session))
        )
    ]
        |> List.map Html.Styled.toUnstyled



-- STYLE


containerStyles : List Css.Style
containerStyles =
    [ Css.paddingLeft (Css.px 15)
    , Css.paddingRight (Css.px 15)
    , Css.marginLeft Css.auto
    , Css.marginRight Css.auto
    , Css.Media.withMedia
        [ Css.Media.all [ Css.Media.minWidth (Css.px 1200) ] ]
        [ Css.maxWidth (Css.px 1140) ]
    , Css.Media.withMedia
        [ Css.Media.all [ Css.Media.minWidth (Css.px 768) ] ]
        [ Css.maxWidth (Css.px 720) ]
    , Css.Media.withMedia
        [ Css.Media.all [ Css.Media.minWidth (Css.px 992) ] ]
        [ Css.maxWidth (Css.px 960) ]
    , Css.Media.withMedia
        [ Css.Media.all [ Css.Media.minWidth (Css.px 576) ] ]
        [ Css.maxWidth (Css.px 540) ]
    ]



-- UPDATE


type Msg
    = ToggledLanguage Language


update : Msg -> Session -> ( Session, Cmd msg )
update (ToggledLanguage language) session =
    ( { session | language = language }, Cmd.none )
