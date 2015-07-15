module App where

import Html exposing (..)
import Html.Attributes exposing (..)

import Router exposing (RouteHandler(..), (<~))

import Pages.Home as Home
import Pages.About as About


routes =
    [ ("/", Handler "index")
    , ("/about", Handler "about")
    --, ("/posts", NestedHandler "posts"
    --    [ ("/", Handler "postsIndex")
    --    , ("/:id", Handler "postsShow")
    --    ])
    ]

handlers =
    [ "/" <~ Home.view
    , "/about" <~ About.view
    ]


main = layout <| div [] [ text "Hello, World!" ]


layout : Html -> Html
layout outlet =
    div [ class "container" ]
        [ h1 [] [ text "Router Example" ]
        , br [] []
        , outlet
        ]
