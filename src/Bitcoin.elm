module Bitcoin exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class)
import Http
import Json.Decode exposing (Decoder, at, string)


type Model
    = Loading
    | Failure
    | Success String


type Msg
    = GotResult (Result Http.Error String)


api : String
api =
    "https://www.bw.com/exchange/config/controller/website/pricecontroller/getassistprice"


getPrice : Cmd Msg
getPrice =
    Http.get
        { url = api
        , expect = Http.expectJson GotResult decodeContent
        }


decodeContent : Decoder String
decodeContent =
    at [ "datas", "usd", "btc" ] string


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, getPrice )


view : Model -> Html Msg
view model =
    Html.div [ class "bitcoin-usd-price-component" ]
        [ case model of
            Loading ->
                text "loading..."

            Failure ->
                text "failed to fetch new cat image"

            Success price ->
                text price
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        GotResult result ->
            case result of
                Ok price ->
                    ( Success price, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
