module App where

import Html exposing (..)

import Router exposing (RouteHandler(..))


routes =
    [ ("/", Handler "index")
    , ("/about", Handler "about")
    , ("/posts", NestedHandler "posts"
        [ ("/", Handler "postsIndex")
        , ("/:id", Handler "postsShow")
        ])
    ]


main = div [] [ text "Hello, World!" ]
