module Images exposing (..)

import Css
import Style
import Svg
import Svg.Attributes
import Svg.Styled as SS
import Svg.Styled.Attributes as SSA


avatarBase64 : String
avatarBase64 =
    "data:image/webp;base64, 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"


en : Svg.Svg msg
en =
    Svg.svg
        [ Svg.Attributes.height "100%"
        , Svg.Attributes.version "1.1"
        , Svg.Attributes.viewBox "0 0 1.65 0.82500095"
        ]
        [ Svg.clipPath [ Svg.Attributes.id "t" ]
            [ Svg.path [ Svg.Attributes.d "m 30,15 30,0 0,15 z m 0,0 0,15 -30,0 z M 30,15 0,15 0,0 Z m 0,0 0,-15 30,0 z" ] [] ]
        , Svg.path
            [ Svg.Attributes.d "M 0,9.9999999e-7 0,0.825001 l 1.65,0 0,-0.82500000000001 z"
            , Svg.Attributes.style "fill:#00247d"
            ]
            []
        , Svg.path
            [ Svg.Attributes.d "M 0.18450781,9.9999999e-7 0,9.9999999e-7 0,0.09225 0.64050293,0.412501 0,0.732752 l 0,0.092249 0.18450781,0 L 0.825,0.504776 1.4654922,0.825001 1.65,0.825001 1.65,0.732752 1.0094971,0.412501 1.65,0.09225 1.65,0 1.4654922,0 0.825,0.320226 0.18450781,9.9999999e-7 Z"
            , Svg.Attributes.style "color:#000000;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:medium;line-height:normal;font-family:sans-serif;text-indent:0;text-align:start;text-decoration:none;text-decoration-line:none;text-decoration-style:solid;text-decoration-color:#000000;letter-spacing:normal;word-spacing:normal;text-transform:none;direction:ltr;block-progression:tb;writing-mode:lr-tb;baseline-shift:baseline;text-anchor:start;white-space:normal;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#ffffff;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:6;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate"
            ]
            []
        , Svg.path
            [ Svg.Attributes.clipPath "url(#t)"
            , Svg.Attributes.d "M 0,0 60,30 M 60,0 0,30"
            , Svg.Attributes.style "stroke:#cf142b;stroke-width:4"
            , Svg.Attributes.transform "matrix(0.0275,0,0,0.0275,0,10e-7)"
            ]
            []
        , Svg.path
            [ Svg.Attributes.d "M 0.825,9.9999999e-7 0.825,0.825001 M 0,0.412501 l 1.65,0"
            , Svg.Attributes.style "stroke:#ffffff;stroke-width:0.27500001"
            ]
            []
        , Svg.path
            [ Svg.Attributes.d "M 0.825,9.9999999e-7 0.825,0.825001 M 0,0.412501 l 1.65,0"
            , Svg.Attributes.style "stroke:#cf142b;stroke-width:0.16500001"
            ]
            []
        ]


et : Svg.Svg msg
et =
    Svg.svg
        [ Svg.Attributes.version "1.1"
        , Svg.Attributes.viewBox "0 0 33.000004 21"
        , Svg.Attributes.height "100%"
        ]
        [ Svg.g [ Svg.Attributes.transform "translate(-53.785502,-631.36218)" ]
            [ Svg.rect
                [ Svg.Attributes.height "6.99999"
                , Svg.Attributes.rx "0.14659922"
                , Svg.Attributes.ry "0.053864051"
                , Svg.Attributes.style "opacity:1;fill:#0072ce;fill-opacity:1;fill-rule:nonzero;stroke:#ffffff;stroke-width:0;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
                , Svg.Attributes.width "32.999992"
                , Svg.Attributes.x "53.785507"
                , Svg.Attributes.y "631.36218"
                ]
                []
            , Svg.rect
                [ Svg.Attributes.height "6.99999"
                , Svg.Attributes.rx "0.14659922"
                , Svg.Attributes.ry "0.053864051"
                , Svg.Attributes.style "opacity:1;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:#ffffff;stroke-width:0;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
                , Svg.Attributes.width "32.999992"
                , Svg.Attributes.x "53.785507"
                , Svg.Attributes.y "638.36218"
                ]
                []
            , Svg.rect
                [ Svg.Attributes.height "6.99999"
                , Svg.Attributes.rx "0.14659922"
                , Svg.Attributes.ry "0.053864051"
                , Svg.Attributes.style "opacity:1;fill:#ffffff;fill-opacity:1;fill-rule:nonzero;stroke:#ffffff;stroke-width:0;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
                , Svg.Attributes.width "32.999992"
                , Svg.Attributes.x "53.785507"
                , Svg.Attributes.y "645.36218"
                ]
                []
            ]
        ]


etsy : SS.Svg msg
etsy =
    SS.svg
        [ SSA.fill "#f45800"
        , SSA.viewBox "0 0 48 24"
        , SSA.css
            [ Css.padding4 (Css.rem 0.6) (Css.rem 0.5) (Css.rem 0.4) (Css.rem 0.5)
            , Css.height (Css.rem 2)
            ]
        ]
        [ SS.path
            [ SSA.d "M6.547,3.125v6.008c0,0,2.117,0,3.25-0.086c0.891-0.156,1.055-0.242,1.219-1.133l0.328-1.305h0.969l-0.164,2.852 l0.086,2.922h-0.977l-0.242-1.141c-0.242-0.812-0.57-0.977-1.219-1.055c-0.812-0.086-3.25-0.086-3.25-0.086v5.039 c0,0.969,0.492,1.383,1.625,1.383h3.414c1.055,0,2.109-0.086,2.766-1.625l0.883-1.953h0.82c-0.086,0.406-0.492,3.984-0.57,4.789 c0,0-3.086-0.078-4.383-0.078H5.25l-3.492,0.078v-0.883l1.133-0.25c0.82-0.164,1.062-0.406,1.062-1.055 c0,0,0.086-2.195,0.086-5.852c0-3.648-0.086-5.844-0.086-5.844c0-0.727-0.242-0.891-1.062-1.055L1.758,2.555V1.664l3.414,0.07h6.5 c1.297,0,3.484-0.234,3.484-0.234s-0.078,1.375-0.164,4.625h-0.891l-0.328-1.141c-0.32-1.461-0.805-2.188-1.703-2.188H6.961 C6.547,2.797,6.547,2.875,6.547,3.125z M19.703,3.766h0.977V7.18l3.336-0.164l-0.164,1.547l-3.25-0.25v6.016 c0,1.703,0.57,2.359,1.547,2.359c0.883,0,1.539-0.492,1.781-0.898l0.484,0.57c-0.484,1.133-1.859,1.703-3.164,1.703 c-1.617,0-2.93-0.969-2.93-2.836V8.398h-1.938V7.586C18.008,7.422,19.219,6.445,19.703,3.766z M26.695,14.242l0.648,1.547 c0.242,0.648,0.812,1.305,2.109,1.305c1.383,0,1.953-0.734,1.953-1.625c0-2.766-5.445-1.953-5.445-5.688c0-2.109,1.703-3.094,3.898-3.094c0.977,0,2.438,0.164,3.172,0.492c-0.164,0.812-0.25,1.867-0.25,2.68l-0.805,0.078l-0.57-1.625 c-0.164-0.398-0.82-0.727-1.625-0.727c-0.977,0-1.953,0.406-1.953,1.461c0,2.516,5.609,1.953,5.609,5.688c0,2.117-1.867,3.25-4.148,3.25c-1.703,0-3.414-0.656-3.414-0.656c0.164-0.969,0.086-2.023,0-3.086H26.695z M33.031,22.039 c0.242-0.891,0.406-2.023,0.57-3.086l0.891-0.078l0.328,1.703c0.078,0.406,0.32,0.734,0.969,0.734c1.055,0,2.438-0.648,3.742-2.922 c-0.578-1.383-2.281-5.844-3.828-9.258c-0.406-0.898-0.484-0.977-1.047-1.141l-0.414-0.156v-0.82l2.445,0.086l3-0.164V7.75 l-0.734,0.164c-0.57,0.078-0.805,0.398-0.805,0.727c0,0.086,0,0.164,0.078,0.328c0.156,0.492,1.461,4.141,2.438,6.578c0.805-1.703,2.352-5.523,2.594-6.172c0.086-0.328,0.164-0.406,0.164-0.648c0-0.414-0.242-0.656-0.805-0.812L42.039,7.75V6.938 l2.281,0.078l2.109-0.078V7.75l-0.406,0.32c-0.812,0.328-0.898,0.406-1.219,1.062l-3.57,8.359 c-2.117,4.797-4.312,5.203-5.852,5.203C34.406,22.695,33.672,22.445,33.031,22.039z"
            ]
            []
        ]


instagram : SS.Svg msg
instagram =
    SS.svg
        [ SSA.viewBox "0 0 504 504"
        , SSA.css [ Css.padding (Css.rem 0.25), Css.height (Css.rem 2.5) ]
        , SSA.fill "#FFFFFF"
        ]
        [ SS.path
            [ SSA.d "M251.921,0.159 C183.503,0.159 174.924,0.449 148.054,1.675 C121.24,2.898 102.927,7.157 86.903,13.385 C70.337,19.822 56.288,28.436 42.282,42.441 C28.277,56.447 19.663,70.496 13.226,87.062 C6.998,103.086 2.739,121.399 1.516,148.213 C0.29,175.083 0,183.662 0,252.08 C0,320.497 0.29,329.076 1.516,355.946 C2.739,382.76 6.998,401.073 13.226,417.097 C19.663,433.663 28.277,447.712 42.282,461.718 C56.288,475.723 70.337,484.337 86.903,490.775 C102.927,497.002 121.24,501.261 148.054,502.484 C174.924,503.71 183.503,504 251.921,504 C320.338,504 328.917,503.71 355.787,502.484 C382.601,501.261 400.914,497.002 416.938,490.775 C433.504,484.337 447.553,475.723 461.559,461.718 C475.564,447.712 484.178,433.663 490.616,417.097 C496.843,401.073 501.102,382.76 502.325,355.946 C503.551,329.076 503.841,320.497 503.841,252.08 C503.841,183.662 503.551,175.083 502.325,148.213 C501.102,121.399 496.843,103.086 490.616,87.062 C484.178,70.496 475.564,56.447 461.559,42.441 C447.553,28.436 433.504,19.822 416.938,13.385 C400.914,7.157 382.601,2.898 355.787,1.675 C328.917,0.449 320.338,0.159 251.921,0.159 Z M251.921,45.55 C319.186,45.55 327.154,45.807 353.718,47.019 C378.28,48.139 391.619,52.243 400.496,55.693 C412.255,60.263 420.647,65.722 429.462,74.538 C438.278,83.353 443.737,91.745 448.307,103.504 C451.757,112.381 455.861,125.72 456.981,150.282 C458.193,176.846 458.45,184.814 458.45,252.08 C458.45,319.345 458.193,327.313 456.981,353.877 C455.861,378.439 451.757,391.778 448.307,400.655 C443.737,412.414 438.278,420.806 429.462,429.621 C420.647,438.437 412.255,443.896 400.496,448.466 C391.619,451.916 378.28,456.02 353.718,457.14 C327.158,458.352 319.191,458.609 251.921,458.609 C184.65,458.609 176.684,458.352 150.123,457.14 C125.561,456.02 112.222,451.916 103.345,448.466 C91.586,443.896 83.194,438.437 74.379,429.621 C65.564,420.806 60.104,412.414 55.534,400.655 C52.084,391.778 47.98,378.439 46.86,353.877 C45.648,327.313 45.391,319.345 45.391,252.08 C45.391,184.814 45.648,176.846 46.86,150.282 C47.98,125.72 52.084,112.381 55.534,103.504 C60.104,91.745 65.563,83.353 74.379,74.538 C83.194,65.722 91.586,60.263 103.345,55.693 C112.222,52.243 125.561,48.139 150.123,47.019 C176.687,45.807 184.655,45.55 251.921,45.55 Z"
            ]
            []
        , SS.path
            [ SSA.d "M251.921,336.053 C205.543,336.053 167.947,298.457 167.947,252.08 C167.947,205.702 205.543,168.106 251.921,168.106 C298.298,168.106 335.894,205.702 335.894,252.08 C335.894,298.457 298.298,336.053 251.921,336.053 Z M251.921,122.715 C180.474,122.715 122.556,180.633 122.556,252.08 C122.556,323.526 180.474,381.444 251.921,381.444 C323.367,381.444 381.285,323.526 381.285,252.08 C381.285,180.633 323.367,122.715 251.921,122.715 Z"
            ]
            []
        , SS.path
            [ SSA.d "M416.627,117.604 C416.627,134.3 403.092,147.834 386.396,147.834 C369.701,147.834 356.166,134.3 356.166,117.604 C356.166,100.908 369.701,87.373 386.396,87.373 C403.092,87.373 416.627,100.908 416.627,117.604"
            ]
            []
        ]


facebook : SS.Svg msg
facebook =
    SS.svg
        [ SSA.viewBox "0 0 5.8208334 5.8208335"
        , SSA.css [ Css.height Style.buttonHeight ]
        ]
        [ SS.g [ SSA.transform "translate(0,-291.17915)" ]
            [ SS.path
                [ SSA.d "m 16.019531,1103.8418 c -0.158475,0 -0.312906,0.01 -0.464843,0.02 -0.151862,0.012 -0.300179,0.03 -0.445313,0.053 -0.145134,0.024 -0.288206,0.056 -0.425781,0.09 -0.13784,0.036 -0.270753,0.078 -0.400391,0.125 -0.130016,0.047 -0.255252,0.1012 -0.376953,0.1602 -0.121323,0.059 -0.238933,0.123 -0.351562,0.1933 -0.11263,0.07 -0.22066,0.1469 -0.324219,0.2285 -0.103559,0.082 -0.203143,0.1688 -0.296875,0.2618 -0.09373,0.093 -0.18172,0.189 -0.265625,0.2929 -0.08391,0.1036 -0.163006,0.2136 -0.236328,0.3282 -0.07332,0.1145 -0.141141,0.2358 -0.203125,0.3613 -0.06198,0.1256 -0.117323,0.2565 -0.167969,0.3926 -0.05027,0.1359 -0.09621,0.2771 -0.134766,0.4238 -0.03855,0.1466 -0.06925,0.2978 -0.0957,0.4551 -0.02532,0.157 -0.04543,0.3208 -0.06055,0.4882 -0.01134,0.1676 -0.01953,0.34 -0.01953,0.5176 v 2.4473 H 8.8847656 V 1114 H 11.75 v 8.5195 h 3.427734 V 1114 h 2.859375 l 0.427735,-3.3203 h -3.28711 v -2.1211 c 0,-0.1202 0.0023,-0.2338 0.01367,-0.3438 0.0102,-0.1099 0.0281,-0.2142 0.05078,-0.3125 0.02343,-0.098 0.05406,-0.1919 0.09375,-0.2773 0.04006,-0.085 0.08872,-0.1633 0.148437,-0.2344 0.05972,-0.071 0.129741,-0.1342 0.212891,-0.1894 0.08277,-0.055 0.177503,-0.1025 0.287109,-0.1407 0.109606,-0.038 0.23396,-0.069 0.373047,-0.088 0.139162,-0.019 0.29445,-0.029 0.466797,-0.029 h 1.757812 v -2.9687 c -0.15205,-0.02 -0.488744,-0.054 -0.939453,-0.08 -0.450708,-0.028 -1.015941,-0.051 -1.623047,-0.051 z"
                , SSA.style "opacity:1;fill:#29487d;fill-opacity:1;fill-rule:nonzero;stroke:#000000;stroke-width:0;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
                , SSA.transform "scale(0.26458333)"
                ]
                []
            ]
        ]
