<div align = "center">
<img src = "https://github.com/ChifiSource/image_dump/blob/main/toolips/toolipsSVG.png"></img>
</br>
</br>
</div>

ToolipsSVG provides SVG components, a `Component{:path}` mutation interface, a multiple dispatch interface for managing and setting size, shape, and positions of different components, and SVG shapes for [Toolips](https://github.com/ChifiSource/Toolips.jl) / [ToolipsServables](https://github.com/ChifiSource/ToolipsServables.jl).
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
  - [adding ToolipsSVG](#adding-toolipssvg)
