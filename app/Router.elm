module Router where


-- TYPES

type alias Url = String
type alias HandlerName = String

type alias Route = (Url, RouteHandler)

type RouteHandler
    = Handler HandlerName
    | NestedHandler HandlerName (List Route)
