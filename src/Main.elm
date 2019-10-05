module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html.Styled
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
    | Item Item.Model


init : Json.Decode.Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    changeRouteTo (Route.fromUrl url)
        (Redirect
            (Session navKey
                (Json.Decode.decodeValue Language.decode flags
                    |> Result.withDefault Language.EN
                )
            )
        )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    (case model of
        Redirect _ ->
            []

        Home session ->
            List.map (Html.Styled.map GotHomeMsg) (Home.view session)

        Item pageModel ->
            Item.view pageModel

        NotFound session ->
            NotFound.view session
    )
        |> (\a ->
                { title = "Salmefelt"
                , body = a |> List.map Html.Styled.toUnstyled
                }
           )



-- UPDATE


type Msg
    = GotHomeMsg Home.Msg
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

        Item pageModel ->
            Item.toSession pageModel


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session : Session
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just (Route.Item itemIndex imageIndex) ->
            ( Item <| Item.Model session itemIndex imageIndex, Cmd.none )

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

        ( GotHomeMsg subMsg, Home session ) ->
            Home.update subMsg session |> Tuple.mapBoth Home (Cmd.map GotHomeMsg)

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
