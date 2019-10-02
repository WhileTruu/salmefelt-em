module Common.Types.Product exposing (Product, decoder)

import Common.Types.Product.Images as ProductImages exposing (ProductImages)
import Json.Decode exposing (Decoder, field, int, string)


type alias Product =
    { id : Int
    , position : Int
    , nameEN : String
    , nameET : String
    , descriptionEN : String
    , descriptionET : String
    , images : ProductImages
    }


decoder : Decoder Product
decoder =
    Json.Decode.succeed (Product 0)
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "priority" int))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "titleEn" string))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "titleEt" string))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "bodyEn" string))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "bodyEt" string))
        |> Json.Decode.andThen (\a -> Json.Decode.map a (field "galleryImages" ProductImages.decoder))
