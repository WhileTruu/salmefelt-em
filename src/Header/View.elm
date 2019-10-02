module Header.View exposing (view)

import Button
import Html exposing (Html, a, div, h3, header, img, text)
import Html.Attributes exposing (alt, class, classList, href, src)
import Language exposing (Language)
import Logo
import Session exposing (Session)
import Translations exposing (Translations)
import Utilities exposing (ifThenElse)


t : Session -> (Translations -> a) -> a
t session translate =
    translate <| Translations.forLanguage session.language


logo : Bool -> Html msg
logo isCompact =
    a
        (ifThenElse isCompact [ href <| "/" ] [])
        [ Logo.image ]


languageButton : Language -> Language -> msg -> Html msg
languageButton buttonLanguage selectedLanguage msg =
    let
        languageString =
            buttonLanguage |> Language.toString |> String.toLower
    in
    Button.small
        msg
        (buttonLanguage == selectedLanguage)
        [ img [ alt <| languageString ++ " flag", src <| "/assets/images/" ++ languageString ++ ".svg" ] [] ]



-- languageButtons : Language -> Html Msg
-- languageButtons language =
--     div [ class "language-buttons" ]
--         [ languageButton Language.EN language ToggleLanguage, languageButton Language.ET language ToggleLanguage ]


externalLinks : Session -> Html msg
externalLinks session =
    div [ class "external-links" ]
        [ Button.link
            [ "facebook" ]
            (t session .links_facebook)
            [ img [ alt "links.facebook", src "/assets/images/facebook.svg" ] [] ]
        , Button.link
            [ "etsy" ]
            (t session .links_etsy)
            [ img [ alt "links.etsy", src "/assets/images/etsy.svg" ] [] ]
        , Button.link
            [ "instagram" ]
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
                , a [ class "link link--dark", href <| "tel:" ++ t session .phonenumber ]
                    [ text <| t session .phonenumber ]
                ]
            , div []
                [ text <| t session .email ++ ": "
                , a
                    [ class "link link--dark", href <| "mailto:" ++ t session .email_address ]
                    [ text <| t session .email_address ]
                ]
            ]
        ]


view : Session -> Html msg
view session =
    let
        isCompact =
            False
    in
    header [ class "header container", classList [ ( "compact", isCompact ) ] ]
        ([ div
            [ class "logo-section", classList [ ( "compact", isCompact ) ] ]
            [ logo isCompact ]

         -- , languageButtons language ]
         ]
            ++ ifThenElse isCompact [] [ h3 [] [ text <| t session .header_slogan ] ]
            ++ ifThenElse isCompact [] [ contactInformation session ]
            ++ ifThenElse isCompact [] [ externalLinks session ]
        )
