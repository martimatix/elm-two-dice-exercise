import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Random

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { dieFaces: (Int, Int)}

init : (Model, Cmd Msg)
init =
  (Model (1, 1)
  , Cmd.none)


type Msg
  = Roll
  | NewFaces (Int, Int)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFaces diePairGenerator)

    NewFaces newFaces ->
      (Model newFaces, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (getDiceVal model 1 ) ]
    , h1 [] [ text (getDiceVal model 2 ) ]
    , button [ onClick Roll ] [ text "Roll"]
    ]

dieGenerator : Random.Generator Int
dieGenerator =
  Random.int 1 6

diePairGenerator : Random.Generator (Int, Int)
diePairGenerator =
  Random.pair dieGenerator dieGenerator

getDiceVal : Model -> Int -> String
getDiceVal model dieNumber =
  let
    (a, b) = model.dieFaces
  in
    case dieNumber of
      1 -> (toString a)
      2 -> (toString b)
      _ -> ""
