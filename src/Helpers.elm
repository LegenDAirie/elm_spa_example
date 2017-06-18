module Helpers exposing (link)

import Html exposing (Html, text, a)
import Html.Attributes exposing (href)
import Route


link : ( Route.Route, String ) -> Html msg
link ( route, label ) =
    a [ Route.urlFor route |> href ] [ text label ]
