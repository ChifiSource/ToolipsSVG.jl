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
  - [position and size](#position-and-size)
  - [shape](#shape)
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
All of these are normal components, which are used like any other component so long as the correct argument is provided.
```julia
```
###### shapes
#### paths
#### position and size
#### shape
