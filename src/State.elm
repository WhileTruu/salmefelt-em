module State exposing (init, update)

import Browser
import Browser.Navigation as Nav
import Common.Api as Api
import Common.Ports
import Common.Types.Language as Language exposing (Language)
import Common.Types.Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
import Dict exposing (Dict)
import Http
import Json.Decode
import Routing
import Types exposing (Flags, Model, Msg(..))
import Url exposing (Url)


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , route = Routing.parseUrl url
      , language =
            flags
                |> Json.Decode.decodeValue Language.decode
                |> Result.withDefault Language.EN
      , products = Dict.empty
      }
    , Http.send GetProducts Api.getProducts
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleLanguage ->
            ( { model | language = model.language |> Language.toggle }
            , Common.Ports.storeLanguage (model.language |> Language.toggle |> Language.toString)
            )

        GetProducts (Ok products) ->
            ( { model | products = products }, Cmd.none )

        GetProducts (Err string) ->
            -- TODO: Add real error handling
            ( model, Cmd.none )

        SelectProductImage index productImage ->
            ( { model
                | products =
                    replaceActiveProductImageInProducts index productImage model.products
              }
            , Cmd.none
            )

        GoToProductPage path index productImage ->
            ( { model
                | products = replaceActiveProductImageInProducts index productImage model.products
              }
            , Nav.pushUrl model.key path
            )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ChangedUrl url ->
            ( { model | route = Routing.parseUrl url }, Cmd.none )


replaceActiveProductImageInProducts : Int -> ProductImage -> Dict Int Product -> Dict Int Product
replaceActiveProductImageInProducts index productImage products =
    products
        |> Dict.update
            index
            (Maybe.map
                (\product ->
                    { product | images = ProductImages.select productImage product.images }
                )
            )
