module Item exposing (..)

import Time


type alias Item =
    { titleEn : String
    , titleEt : String
    , date : Time.Posix
    , priority : Int
    , bodyEn : String
    , bodyEt : String
    , galleryImages : List String
    }
