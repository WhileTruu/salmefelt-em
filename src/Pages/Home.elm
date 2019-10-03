module Pages.Home exposing (Msg, update, view)

import Button
import Html exposing (Html, div, h2, h3, img, p, section, text)
import Html.Attributes exposing (alt, class, href, src)
import Item exposing (Item)
import Items
import Language as Language exposing (Language)
import Logo
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


languageButton : Language -> Language -> Html Msg
languageButton language selectedLanguage =
    let
        languageString =
            language |> Language.toString |> String.toLower
    in
    Button.small
        (ToggledLanguage language)
        (language == selectedLanguage)
        [ img [ alt <| languageString ++ " flag", src <| "/assets/images/" ++ languageString ++ ".svg" ] [] ]


languageButtons : Language -> Html Msg
languageButtons language =
    div [ class "language-buttons" ]
        [ languageButton Language.EN language
        , languageButton Language.ET language
        ]


externalLinks : Session -> Html msg
externalLinks session =
    div [ class "external-links" ]
        [ Button.link [ "facebook" ]
            (t session .links_facebook)
            [ img [ alt "links.facebook", src "/assets/images/facebook.svg" ] [] ]
        , Button.link [ "etsy" ]
            (t session .links_etsy)
            [ img [ alt "links.etsy", src "/assets/images/etsy.svg" ] [] ]
        , Button.link [ "instagram" ]
            (t session .links_instagram)
            [ img [ alt "link.instagram", src "/assets/images/instagram.svg" ] [] ]
        ]


contactInformation : Session -> Html msg
contactInformation session =
    div [ class "contact-information" ]
        [ div [ class "avatar" ] [ img [ alt "avatar", src "/assets/images/avatar.jpg" ] [] ]
        , div []
            [ text <| t session .contact_name
            , div []
                [ text <| t session .phone ++ ": "
                , Html.a [ class "link link--dark", href <| "tel:" ++ t session .phonenumber ]
                    [ text <| t session .phonenumber ]
                ]
            , div []
                [ text <| t session .email ++ ": "
                , Html.a
                    [ class "link link--dark", href <| "mailto:" ++ t session .email_address ]
                    [ text <| t session .email_address ]
                ]
            ]
        ]


headerView : Session -> Html Msg
headerView ({ language } as session) =
    Html.header [ class "header container" ]
        [ div [ class "logo-section" ] [ Logo.image, languageButtons language ]
        , h3 [] [ text <| t session .header_slogan ]
        , contactInformation session
        , externalLinks session
        ]


view : Session -> List (Html Msg)
view session =
    [ headerView session
    , section [ class "container products" ]
        (intro session
            :: (List.sortBy .priority Items.all |> List.indexedMap (productList session))
        )
    ]



-- UPDATE


type Msg
    = ClickedChangeRoute Route
    | ToggledLanguage Language


update : Msg -> Session -> ( Session, Cmd msg )
update msg session =
    case msg of
        ClickedChangeRoute route ->
            ( session, Route.pushUrl session.navKey route )

        ToggledLanguage language ->
            ( { session | language = language }, Cmd.none )
