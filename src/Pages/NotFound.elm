module Pages.NotFound exposing (view)

import Html exposing (Html, h1, p, section, text)
import Html.Attributes exposing (class)
import Session exposing (Session)
import Translations exposing (Translations)


view : Session -> List (Html msg)
view session =
    [ section [ class "container" ]
        [ h1 [] [ text "404" ]
        , p [] [ text (Translations.forLanguage session.language).page_not_found ]
        ]
    ]
