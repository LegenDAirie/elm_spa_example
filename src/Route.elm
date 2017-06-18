module Route exposing (..)

import Navigation


type Route
    = Home
    | Topics


navLocationToRoute : Navigation.Location -> Maybe Route
navLocationToRoute path =
    let
        segments =
            path.hash
                |> String.split "/"
                |> List.filter (\segment -> segment /= "" && segment /= "#")
    in
        case segments of
            [ "topics" ] ->
                Just Topics

            [] ->
                Just Home

            _ ->
                Nothing


urlFor : Route -> String
urlFor route =
    case route of
        Home ->
            "#/"

        Topics ->
            "#/topics"
