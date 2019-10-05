module Translations exposing (Translations, forLanguage)

import Language as Language exposing (Language)


type alias Translations =
    { header_slogan : String
    , body_text : List String
    , email : String
    , email_address : String
    , phone : String
    , phonenumber : String
    , contact : String
    , contact_name : String
    , address_translation : String
    , address : List String
    , company_name : String
    , links_facebook : String
    , links_etsy : String
    , links_instagram : String
    , page_not_found : String
    }


english : Translations
english =
    { header_slogan = "modern felt handicraft inspired by Estonian history"
    , body_text =
        [ "Welcome to Salmefelt Ltd handicraft products page."
        , "My creations come from deep within my heart and carry my joy and feelings."
        ]
    , email = "e-mail"
    , email_address = "salmefelt@gmail.com"
    , phone = "phone"
    , phonenumber = "+372 5345 2868"
    , contact = "contact us"
    , contact_name = "Taivi Truu"
    , address_translation = "address"
    , address = [ "Aia 4, Salme alev, 93201", "Saaremaa, Estonia" ]
    , company_name = "Salmefelt Ltd"
    , links_facebook = "https://www.facebook.com/salmefelt"
    , links_etsy = "https://www.etsy.com/shop/salmefelt"
    , links_instagram = "https://www.instagram.com/salmefelt"
    , page_not_found = "This page does not exist. 😞"
    }


estonian : Translations
estonian =
    { header_slogan = "ajaloost inspireeritud modernsed viltesemed"
    , body_text =
        [ "Tere tulemast tutvuma Salmefelt OÜ käsitöötoodetega."
        , "Minu looming tuleb sügavalt südamest ja kannab edasi mu rõõme ja tundeid."
        ]
    , email = "e-post"
    , email_address = "salmefelt@gmail.com"
    , phone = "telefon"
    , phonenumber = "+372 5345 2868"
    , contact = "kontakt"
    , contact_name = "Taivi Truu"
    , address_translation = "aadress"
    , address = [ "Aia 4, Salme alev, 93201", "Saaremaa, Estonia" ]
    , company_name = "Salmefelt OÜ"
    , links_facebook = "https://www.facebook.com/salmefelt"
    , links_etsy = "https://www.etsy.com/shop/salmefelt"
    , links_instagram = "https://www.instagram.com/salmefelt"
    , page_not_found = "Seda lehte pole olemas. 😞"
    }


forLanguage : Language -> Translations
forLanguage language =
    case language of
        Language.ET ->
            estonian

        Language.EN ->
            english
