# Spock & Elm Full-Stack

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template/NSeGz_?referralCode=Y68pBw)

This is a basic full-stack app example using Haskell, [Spock](https://spock.li), and [Elm](https://elm-lang.org).

## Adding a Page
To add a page, first create an Elm module, e.g.:

```elm
module MyPage exposing (..)


import Browser
import Html exposing (Html, div, text)

-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model = ()

init : Model
init =
  ()

-- UPDATE
type alias Msg = ()

update : Msg -> Model -> Model
update _ model =
  model

-- VIEW
view : Model -> Html Msg
view _ =
  div [] [text "Hello!"]
```

Then, add it to the `buildElm` list in `Setup.hs`:

```haskell
...
postBuild = buildElm ["Main", "About", "MyPage"]
...
```

And finally, add a route in `app/Main.hs`, in the `app` function:

```haskell
app =
    do middleware (staticPolicy (addBase "static"))
       ...
       get "my-page" $ renderElm "My Page" "MyPage"
       ...
```
