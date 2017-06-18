module Page.Topics exposing (view, fakeTopics, viewTopic)

import Html exposing (Html, text, ul, li)
import Route
import Helpers exposing (link)


type alias Topic =
    { id : Int
    , title : String
    , slug : String
    }


fakeTopics : List Topic
fakeTopics =
    [ { id = 1, title = "Cats", slug = "cats" }
    , { id = 2, title = "Dogs", slug = "dogs" }
    , { id = 3, title = "Chickens", slug = "chickens" }
    ]


view : List Topic -> Html msg
view topics =
    ul []
        (List.map viewTopicListItem topics)


viewTopic : String -> List Topic -> Html msg
viewTopic slug topics =
    let
        currentTopic =
            List.filter (\topic -> topic.slug == slug) topics
                |> List.head
    in
        case currentTopic of
            Just topic ->
                text ("this is the " ++ topic.slug ++ " topic")

            Nothing ->
                text "Topic not found!"


viewTopicListItem : Topic -> Html msg
viewTopicListItem topic =
    li [] [ link ( Route.Topic topic.slug, topic.title ) ]
