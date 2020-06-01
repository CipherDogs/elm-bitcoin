module Bitcoin exposing (..)

{-| Bitcoin price web component made using Elm. Thanks to this extension, you can reflect in your application the current price of bitcoin in dollars.

Use component

@docs Model, init
@docs update, Msg
@docs view

@docs api, getPrice, decodeContent

-}

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


{-| API Endpoint
-}
api : String
api =
    "https://www.bw.com/exchange/config/controller/website/pricecontroller/getassistprice"


{-| Bitcoin price HTTP Request
-}
getPrice : Cmd Msg
getPrice =
    Http.get
        { url = api
        , expect = Http.expectJson GotResult decodeContent
        }


{-| JSON parse
-}
decodeContent : Decoder String
decodeContent =
    at [ "datas", "usd", "btc" ] string


{-| Сomponent initialization
-}
init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, getPrice )


{-| Component display
-}
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


{-| Update state
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        GotResult result ->
            case result of
                Ok price ->
                    ( Success price, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )
