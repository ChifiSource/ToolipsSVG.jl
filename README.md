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
- [contributing](#contributing)
  - [contributing guidelines](#guidelines)
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

The shape interface consists of
- `get_position`
- `set_position!`
- `size(::Component{<:Any})`
- `set_size!`
- `set_shape`
- `get_shape`

This interface provides us with an easy way to consistently get and set the position of different shapes and also translate shapes between eachother with `set_shape`.
```julia
window[:children] = window[:children][1:3]
window[:children] = [set_shape(comp, :star) for comp in window[:children]]
```

<img src="https://github.com/ChifiSource/image_dump/blob/main/toolips/tlsvgsc/Screenshot%20from%202024-04-26%2018-23-08.png"></img>
#### paths
The last noteworthy feature in `ToolipsSVG` is an interface for drawing `d` data in paths. This is a rather small interface, but can be quite effective. Each argument will be provided to `d` with a space; beyond this, it is simply knowing how to use SVG.
```julia
using ToolipsSVG
squarepath = path("new-square")
M!(squarepath, 50, 50)
L!(squarepath, 100, 50)
L!(squarepath, 100, 100)
L!(squarepath, 50, 100)
L!(squarepath, 50, 50)
Z!(squarepath)
```
```julia
window = svg("main", width = 200, height = 200, children = [squarepath])
cont = div("holder", children = [window])
style!(cont, "padding" => 10px)
cont
```
<div align="center">
<img src="https://github.com/ChifiSource/image_dump/blob/main/toolips/tlsvgsc/Screenshot%20from%202024-04-26%2018-31-25.png"></img>
</div>

Let's try a more advanced example ...
```julia
cuteheart = path("heart")
M!(cuteheart, 12, "21.593c-5.63-5.539-11-10.297-11-14.402", 
"0-3.791 3.068-5.191 5.281-5.191 1.312", 0, "4.151.501", 
5.719, 4.457, "1.59-3.968", "4.464-4.447",
 "5.726-4.447", 2.54, 0, 5.274, 1.621, 5.274, 5.181, 0,
 "4.069-5.136 8.625-11", "14.402m5.726-20.583c-2.203", "0-4.446 1.042-5.726 3.238-1.285-2.206-3.522-3.248-5.719-3.248-3.183",
  "0-6.281", "2.187-6.281", 6.191, 0, 4.661, 5.571, 9.429, 12, 15.809, "6.43-6.38 12-11.148 12-15.809",
   "0-4.011-3.095-6.181-6.274-6.181")

neww = svg(width = 25, height = 25, children = [cuteheart])
```

<div align="center">
  <img src="https://github.com/ChifiSource/image_dump/blob/main/toolips/tlsvgsc/Screenshot%20from%202024-04-26%2020-42-52.png"></img>
</div>

### contributing
Thank you for lending a helping hand in the development of this package, and others like it. There are a myriad of different ways to contribute to this project.
- submitting [issues](https://github.com/ChifiSource/ToolipsSVG.jl/issues)
- creating packages which use `ToolipsSVG`
- forking and pull-requesting your changes to this code
- trying other [chifi](https://github.com/ChifiSource) projects.
- contributing to other [chifi](https:://github.com/ChifiSource) projects (gives more attention here).
##### guidelines
- If there is no issue for what you want to do, create an issue.
- If you have multiple issues, submit multiple issues rather than typing each issue into one issue.
- Make sure the issue you are solving or feature you want to implement is still feasible on Unstable -- this is the top-level development branch which represents the latest unstable changes.
- Please format your documentation using the technique presented in the rest of the file.
- Make sure Pkg.test("ToolipsSVG") works with your version of ToolipsSVG before making a pull-request.
