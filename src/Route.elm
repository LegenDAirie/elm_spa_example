module Route exposing (..)

import Navigation


type Route
    = Home
    | Topics
    | Topic String


navLocationToRoute : Navigation.Location -> Maybe Route
navLocationToRoute path =
    let
        segments =
            path.hash
                |> String.split "/"
                |> List.filter (\segment -> segment /= "" && segment /= "#")
    in
        case segments of
            [ "topics", slug ] ->
                Just (Topic slug)

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

        Topic slug ->
            "#/topics/" ++ slug
