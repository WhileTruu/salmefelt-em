module Session exposing (..)

import Browser.Navigation as Nav
import Language exposing (Language)


type alias Session =
    { navKey : Nav.Key
    , language : Language
    }
