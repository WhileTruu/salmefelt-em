module Pages.NotFound exposing (view)

import Html.Styled as HS
import Html.Styled.Attributes
import Session exposing (Session)
import Style
import Translations exposing (Translations)


view : Session -> List (HS.Html msg)
view session =
    [ HS.section [ Html.Styled.Attributes.css [ Style.container ] ]
        [ HS.h1 [] [ HS.text "404" ]
        , HS.p []
            [ HS.text (Translations.forLanguage session.language).page_not_found ]
        ]
    ]
