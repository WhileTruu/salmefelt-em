module Style exposing (..)

import Css
import Css.Media
import Css.Transitions



-- CONSTANTS


smallSpacing : Css.Rem
smallSpacing =
    Css.rem 0.8


mediumSpacing : Css.Rem
mediumSpacing =
    Css.rem 1


largeSpacing : Css.Rem
largeSpacing =
    Css.rem 2.5


buttonHeight : Css.Rem
buttonHeight =
    Css.rem 3


buttonBorderRadius : Css.Rem
buttonBorderRadius =
    Css.rem 0.5


linkColor : Css.Color
linkColor =
    Css.hex "#c400de"


darkColor : Css.Color
darkColor =
    Css.hex "#293c4b"


hoverShadow : Css.Style
hoverShadow =
    Css.property "box-shadow" "0 10px 18px rgba(0, 0, 0, 0.11), 0 4px 5px rgba(0, 0, 0, 0.08)"


defaultShadow : Css.Style
defaultShadow =
    Css.property "box-shadow" "0 4px 6px rgba(0, 0, 0, 0.11), 0 1px 3px rgba(0, 0, 0, 0.08)"


focusShadow : Css.Style
focusShadow =
    Css.boxShadow5 Css.zero Css.zero Css.zero (Css.rem 0.25) (Css.rgba 100 100 255 0.5)


textShadow : Css.Style
textShadow =
    Css.property "box-shadow" "0 0 2px rgba(0, 0, 0, 0.11), 0 1px 2px rgba(0, 0, 0, 0.08)"



-- COMPONENTS


roundedButton : Css.Style
roundedButton =
    Css.borderRadius buttonBorderRadius


button : { isSelected : Bool } -> Css.Style
button { isSelected } =
    Css.batch
        ([ Css.position Css.relative
         , Css.display Css.inlineBlock
         , Css.property "user-select" "none"
         , Css.border Css.zero
         , Css.padding <| Css.zero
         , Css.cursor Css.pointer
         , defaultShadow
         , Css.Transitions.transition
            [ Css.Transitions.transform3 200 0 Css.Transitions.easeInOut ]
         , Css.before
            [ Css.property "content" "\"\""
            , Css.position Css.absolute
            , Css.top <| Css.zero
            , Css.left <| Css.zero
            , Css.width <| Css.pct 100
            , Css.height <| Css.pct 100
            , hoverShadow
            , Css.opacity <| Css.zero
            , Css.Transitions.transition
                [ Css.Transitions.opacity3 200 0 Css.Transitions.easeInOut ]
            ]
         , Css.active [ Css.transform <| Css.translateY <| Css.rem 0.05 ]
         , Css.focus [ Css.outline Css.zero, focusShadow ]
         ]
            |> (if isSelected then
                    (++)
                        [ Css.cursor Css.default
                        , Css.transform <| Css.translateY <| Css.rem 0.05
                        ]

                else
                    (++)
                        [ Css.cursor Css.pointer
                        , Css.hover
                            [ Css.transform <| Css.translateY <| Css.rem -0.15
                            , Css.after [ Css.opacity <| Css.num 1 ]
                            ]
                        ]
               )
        )


container : Css.Style
container =
    Css.batch
        [ Css.paddingLeft mediumSpacing
        , Css.paddingRight mediumSpacing
        , Css.marginLeft Css.auto
        , Css.marginRight Css.auto
        , Css.Media.withMedia
            [ Css.Media.all [ Css.Media.minWidth (Css.px 1200) ] ]
            [ Css.maxWidth (Css.px 1140) ]
        , Css.Media.withMedia
            [ Css.Media.all [ Css.Media.minWidth (Css.px 768) ] ]
            [ Css.maxWidth (Css.px 720) ]
        , Css.Media.withMedia
            [ Css.Media.all [ Css.Media.minWidth (Css.px 992) ] ]
            [ Css.maxWidth (Css.px 960) ]
        , Css.Media.withMedia
            [ Css.Media.all [ Css.Media.minWidth (Css.px 576) ] ]
            [ Css.maxWidth (Css.px 540) ]
        ]


gridItem : Css.Style
gridItem =
    Css.batch
        [ Css.width (Css.pct 100)
        , Css.Media.withMedia
            [ Css.Media.only Css.Media.screen [ Css.Media.maxWidth (Css.px 320) ] ]
            [ Css.maxWidth (Css.pct 98)
            , Css.margin (Css.pct 1)
            ]
        , Css.Media.withMedia
            [ Css.Media.only Css.Media.screen [ Css.Media.maxWidth (Css.px 576) ] ]
            [ Css.maxWidth (Css.pct 48)
            , Css.margin (Css.pct 1)
            ]
        , Css.Media.withMedia
            [ Css.Media.only Css.Media.screen [ Css.Media.maxWidth (Css.px 768) ] ]
            [ Css.maxWidth (Css.calc (Css.pct (100 * 1 / 3)) Css.minus (Css.pct 2))
            , Css.margin (Css.pct 1)
            ]
        , Css.Media.withMedia
            [ Css.Media.only Css.Media.screen [ Css.Media.maxWidth (Css.px 1200) ] ]
            [ Css.maxWidth (Css.pct 23)
            , Css.margin (Css.pct 1)
            ]
        , Css.Media.withMedia
            [ Css.Media.only Css.Media.screen [ Css.Media.minWidth (Css.px 1200) ] ]
            [ Css.maxWidth (Css.pct 18)
            , Css.margin (Css.pct 1)
            ]
        ]


hyperlink : Css.Style
hyperlink =
    Css.batch [ Css.color linkColor, Css.textDecoration Css.none ]
