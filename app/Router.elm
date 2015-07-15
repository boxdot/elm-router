module Router where


import Html exposing (..)

-- TYPES

type alias Url = String
type alias HandlerName = String

type alias Route = (Url, RouteHandler)

type RouteHandler
    = Handler HandlerName
    | NestedHandler HandlerName (List Route)


-- API

routeChangeP : Signal.Mailbox HandlerName
routeChangeP = Signal.mailbox ""

onRoute : HandlerName -> Signal HandlerName
onRoute handler =
    Signal.filter ((==) handler) "" routeChangeP.signal

-- RENDER

render : Html -> HandlerName -> Signal Html
render view handler = Signal.map (\_ -> view) (onRoute handler)

(<~) handler view = render view handler

