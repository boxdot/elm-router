Elm.Native.Router = {};
Elm.Native.Router.make = function(localRuntime) {

    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Router = localRuntime.Native.Router || {};

    if (localRuntime.Native.Router.values) {
        return localRuntime.Native.Router.values;
    }

    var List = Elm.Native.List.make(localRuntime);
    var Utils = Elm.Native.Utils.make(localRuntime);

    //
    // router.js
    //

    var router = new Router["default"]();

    // browser url api (TODO: probably replace by some lib)

    var api = {
        getRelativeUrl: function(url) {
            var url = window.location.hash.substr(1);
            return url.length != 0 ? url : "/";
        },

        updateURL: function(url) {
            window.history.pushState({}, '', url);
            api.handleURL(url);
        },

        handleURL: function(url) {
            router.handleURL(api.getRelativeUrl(url));
        },

        watchURLChanges: function(cb) {
            window.addEventListener('popstate', function(e) {
                console.log('popped state', window.location.pathname, e);
                cb(window.location.pathname, e);
            });
        }
    };

    router.updateURL = api.updateURL;

    document.addEventListener('click', function(e) {
        e.preventDefault();

        if (typeof e.target.href !== "undefined") {
            var url = e.target.href.replace(window.location.origin, "");
            console.log("updateURL", url);
            api.updateURL(url);
        }
    });

    // handlers

    var handlers = {};

    function defaultHandler(handlerName) {
        return {
            model: function(s, t) {
                return RSVP.resolve(s);
            },

            serialize: function(s) {
                return {id: s.id};
            },

            setup: function(model) {
                console.log('Model changed! Need to send a signal.');
            },

            events: {   
                error: function(e) {
                    console.log("Error occured in hander:", handlerName);
                    console.error(e);
                }
            }
        };
    }

    router.getHandler = function(name) {
        console.log("getHandler", name);
        if (handlers[name] === undefined) {
            handlers[name] = defaultHandler(name);
        }
        return handlers[name];
    }

    api.watchURLChanges(function(url) {
        api.handleURL(url);
    });

    // Setup

    function addRoutes(routes, match) {
        List.toArray(routes).forEach(function(route) {
            var url = route._0;
            var handler = route._1;

            if (handler.ctor === "Handler") {
                console.log("Add route: ", url, handler._0);
                match(url).to(handler._0);
            } else if (handler.ctor === "NestedHandler") {
                throw new Error("Not implemented!");
            }
        });
    }

    // Ports

    // synchronous
    function setup(routes) {
        router.map(function(match) {
            addRoutes(routes, match);
        });

        api.handleURL(window.location.pathname);

        return Utils.Tuple0;
    }

    return localRuntime.Native.Router.values = {
        setup: setup
    };
}
