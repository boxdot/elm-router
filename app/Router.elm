module Router where

import Html exposing (..)

import Native.Router

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


--setup : List Route -> List (Signal Html) -> Signal Html
--setup routes handlers =
--    let handlers' = Native.Router.embed routes handlers
--    in
--        Signal.mergeMany handlers'

setup : List Route -> ()
setup = Native.Router.setup

-- RENDER

render : Html -> HandlerName -> Signal Html
render view handler = Signal.map (\_ -> view) (onRoute handler)

(<~) handler view = render view handler

