module About exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Html exposing (h1)
import Html exposing (a)
import Html.Attributes exposing (href)
import Html exposing (p)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model = Int


init : Model
init =
  0



-- UPDATE


type Msg
  = Increment
  | Decrement


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1



-- VIEW


view : Model -> Html Msg
view model =
  div [class "container"]
    [ h1 [class "heading"] [text "About"]
    , p [] [ text "This is an example app using "
           , a [href "https://spock.li"] [text "Spock"]
           , text " and "
           , a [href "https://elm-lang.org"] [text "Elm"]
           , text "."]
    , a [href "/"] [text "Back to Home"]
     ]