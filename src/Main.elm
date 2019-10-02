module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html)
import Json.Decode
import Language as Language exposing (Language)
import Pages.Home as Home
import Pages.Item as Item
import Pages.NotFound as NotFound
import Route exposing (Route)
import Session exposing (Session)
import Url exposing (Url)



-- MODEL


type Model
    = Redirect Session
    | NotFound Session
    | Home Session
    | Item Session Int Int


init : Json.Decode.Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    changeRouteTo (Route.fromUrl url)
        (Redirect
            (Session navKey
                (flags
                    |> Json.Decode.decodeValue Language.decode
                    |> Result.withDefault Language.EN
                )
            )
        )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model of
        Redirect session ->
            { title = "Salmefelt"
            , body = []
            }

        Home session ->
            { title = "Salmefelt"
            , body = List.map (Html.map GotHomeMsg) (Home.view session)
            }

        Item session index imageIndex ->
            { title = "Salmefelt"
            , body = List.map (Html.map GotItemMsg) (Item.view session index imageIndex)
            }

        NotFound session ->
            { title = "Salmefelt"
            , body = List.map (Html.map GotItemMsg) (NotFound.view session)
            }



-- UPDATE


type Msg
    = GotItemMsg Item.Msg
    | GotHomeMsg Home.Msg
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest


toSession : Model -> Session
toSession model =
    case model of
        Redirect session ->
            session

        NotFound session ->
            session

        Home session ->
            session

        Item session _ _ ->
            session


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just (Route.Item itemIndex imageIndex) ->
            ( Item session itemIndex imageIndex, Cmd.none )

        Just Route.Home ->
            ( Home session, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            ( model, Cmd.none )

                        Just _ ->
                            ( model
                            , Nav.pushUrl (toSession model).navKey (Url.toString url)
                            )

                Browser.External href ->
                    ( model, Nav.load href )

        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( _, _ ) ->
            ( model, Cmd.none )



-- MAIN


main : Program Json.Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }
