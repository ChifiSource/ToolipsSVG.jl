<div align = "center">
<img src = "https://github.com/ChifiSource/image_dump/blob/main/toolips/toolipsSVG.png"></img>
</br>
</br>
</div>

ToolipsSVG provides SVG components, a `Component{:path}` mutation interface, a multiple dispatch interface for managing and setting size, shape, and positions of different components, and SVG shapes for [Toolips](https://github.com/ChifiSource/Toolips.jl) and [Gattino](https://github.com/ChifiSource/Gattino.jl) powered by [ToolipsServables](https://github.com/ChifiSource/ToolipsServables.jl).
```julia
using ToolipsSVG

window = svg("main", width = 500, height = 500)
squarepath = path("new-square")
M!(squarepath, 50, 50)
L!(squarepath, 100, 50)
L!(squarepath, 100, 100)
L!(squarepath, 50, 100)
L!(squarepath, 50, 50)
Z!(squarepath)

push!(window, squarepath)
display("text/html", window)
```

```julia
st = star("sample", x= 100, y = 150, outer_radius = 15, inner_radius = 40, angle = 20)
style!(st, "fill" => "orange", "stroke" => "green")
push!(window, st)
display("text/html", window)
```
## map
- [get started](#get-started)
  - [adding ToolipsSVG](#adding)
- [components](#components)
  - [shapes](#shapes)
  - [paths](#paths)
#### get started
`ToolipsSVG` may be used with or without a `Toolips` server, but will require an SVG display output of some kind --for example an [IJulia](), [Olive](), [Pluto]() notebook, or [Electron]() window. To show components, call `display("text/html", ::AbstractComponent)`. This will usually be called whenever a `Component` is *shown*, or returned, as well.
```julia
using ToolipsSVG
new_window::Component{:svg} = svg(width = 500, height = 500)
newcircle::Component{:circle} = circle(cx = 250, cy = 250, r = 20)
style!(newcircle, "fill" => "blue")
push!(new_window, newcircle)

display("text/html", new_window)
```

<img src="https://github.com/ChifiSource/image_dump/blob/main/toolips/tlsvgsc/Screenshot%20from%202024-04-26%2011-32-20.png"></img>

###### adding
`ToolipsSVG` can be added via `Pkg`.
```julia
using Pkg; Pkg.add("ToolipsSVG")
```
For the latest updates, which might sometimes be broken, you can also add the `Unstable` branch.
```julia
using Pkg; Pkg.add("ToolipsSVG", rev = "Unstable")
```
###### documentation
We are working on a large documentation website for all of these modules (based on `Toolips`) -- documentation will be available for `0.1.1` -- the first patch of this package. In the mean time, a full list of exports is inside of the `ToolipsSVG` doc-string.
```julia
?ToolipsSVG
```
## components
`ToolipsSVG` builds an SVG interface atop the parametric `Component` type provided by [ToolipsServables](https://github.com/ChifiSource/ToolipsServables.jl). This *begins* with some base `Component` types to provide accessible constants for high-level templating in typical `Toolips` fashion.
```julia
                       #     property                property
     # element (svg) ( id, key       value         key    value  )
sample_svg = svg("mysvg", "prop1" => "sixty-five", prop2 = 5)
```
```julia
text
image
circle
rect
path
line
ellipse
polyline
polygon
use
g
```
All of these are normal components, which are used like any other component. We provide `Pair{String, <:Any}` alongside key-word arguments to give properties with the first positional argument being the name.
```julia
using ToolipsSVG
w, h = 250, 250
window = svg("julia_over", width = w, height = h)
each_w = (w - 10) / 3
each_height = h / 2
circs = [begin
          circ = circle(cx = (each_w * e), cy = each_height, r = 10)
          style!(circ, "fill" => "#$color")
          circ
     end for (e, color) in enumerate(("D5635C", "60AD51", "AA79C1"))]

window[:children] = circs
window
```

<div align="center">
  <img src="https://github.com/ChifiSource/image_dump/blob/main/toolips/tlsvgsc/Screenshot%20from%202024-04-26%2017-46-05.png"></img>
</div>

`ToolipsSVG` also includes two special components, the `Component{:star}` and `Component{:polyshape}`. These are two different pre-made shapes with unique arguments that change how the shape is rendered. For example, a `star`.
```julia
newstar = star("newstar", x = 50, y = 50, points = 5, inner_radius = 14, outer_radius = 30)
push!(window, newstar)
```

<img src="https://github.com/ChifiSource/image_dump/blob/main/toolips/tlsvgsc/Screenshot%20from%202024-04-26%2017-54-57.png"></img>

###### shapes
In addition to just the basic components to work with, `ToolipsSVG` also includes a parametric shape interface. This interface has support for the following shapes:
- `:circle`
- `:rect`
- `:square`
- `:polyshape`
- `:star`

Note that not *all* of these shapes are fully implemented with the API, for example you cannot `set_shape(::Component{:star}, :circle)`. These functions will be filled in as future patches come... The `:circle` component is completely binded. The shape interface consists of
- `get_position`
- `set_position!`
- `get_size`
- `set_size!`
- `set_shape!`
- `get_shape`

```julia
window[:children] = window[:children][1:3]
window[:children] = [set_shape!(comp, :star) for comp in window[:children]]
```
#### paths
Another feature that
