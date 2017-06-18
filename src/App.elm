module App exposing (..)

import Html exposing (Html, text, div, nav, ul, li, a)
import Html.Attributes exposing (src, href)
import Navigation
import Route
import Page.Topics as Topics
import Helpers exposing (link)


---- MODEL ----


type alias Model =
    { route : Maybe Route.Route
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init navLocation =
    let
        newRoute =
            Route.navLocationToRoute navLocation
    in
        { route = newRoute
        }
            ! []



---- UPDATE ----


type Msg
    = NoOp
    | UrlChange (Maybe Route.Route)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        UrlChange path ->
            { model
                | route = path
            }
                ! []



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        body =
            case model.route of
                Just (Route.Home) ->
                    viewHome

                Just (Route.Topics) ->
                    Topics.view Topics.fakeTopics

                Just (Route.Topic slug) ->
                    Topics.viewTopic slug Topics.fakeTopics

                Nothing ->
                    text "Not found!"
    in
        div []
            [ viewNavigation model
            , body
            ]


viewHome : Html Msg
viewHome =
    text "Home page"


viewNavigation : Model -> Html Msg
viewNavigation model =
    nav []
        [ ul []
            (List.map (\item -> li [] [ link item ]) links)
        ]


links : List ( Route.Route, String )
links =
    [ ( Route.Home, "Home" )
    , ( Route.Topics, "Topics" )
    ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program (Route.navLocationToRoute >> UrlChange)
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
