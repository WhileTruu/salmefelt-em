module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Common.Ports
import Common.Types.Language as Language exposing (Language)
import Common.Types.Product as Product exposing (Product)
import Common.Types.Product.Images as ProductImages exposing (ProductImage)
import Dict exposing (Dict)
import Json.Decode
import Routing
import Types exposing (Flags, Model, Msg(..))
import Url exposing (Url)
import View



-- MODEL


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
    , Cmd.none
    )



-- VIEW
-- UPDATE


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



-- MAIN


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = View.view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }
