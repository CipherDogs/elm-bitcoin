# elm-bitcoin
Bitcoin price web component made using Elm. Thanks to this extension, you can reflect in your application the current price of bitcoin in dollars.

## Use

```elm
module Example exposing (view)

import Bitcoin
import Html exposing (..)

view : Html msg
view =
    Html.div [] [ Bitcoin.main ]
```

## CSS

A component has been added to the component so that you can customize it as you wish. The class is called "bitcoin-usd-price-component".