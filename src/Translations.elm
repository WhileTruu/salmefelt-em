module Translations exposing (Translations, forLanguage, t)

import Language as Language exposing (Language)
import Translations.English as English
import Translations.Estonian as Estonian


type alias Translations =
    { slogan : String
    , homePageContent : String
    , email : String
    , emailAddress : String
    , phone : String
    , phoneNumber : String
    , contact : String
    , contactName : String
    , companyName : String
    , pageNotFound : String
    }


forLanguage : Language -> Translations
forLanguage language =
    case language of
        Language.ET ->
            Estonian.translations

        Language.EN ->
            English.translations


t : Language -> (Translations -> a) -> a
t language translate =
    translate <| forLanguage language
