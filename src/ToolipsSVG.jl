"""
Created in February, 2023 by
[chifi - an open source software dynasty.](https://github.com/orgs/ChifiSource)
by team
[toolips](https://github.com/orgs/ChifiSource/teams/toolips)
This software is MIT-licensed.
### ToolipsSVG
This module brings an array of different Components, as well as making things
work more thoroughly with paths.
"""
module ToolipsSVG
import Base: size, string
using ToolipsServables
# TODO Rewrite:

string(comp::Component{:path}) = begin
    text::String = comp.properties[:text]
    children = string(comp[:children])
    extras = string(comp[:extras])
    d_prop::String = "d=\"$(comp.properties["d"])\""
    delete!(comp.properties, "d")
    "$extras<$(comp.tag) id=\"$(comp.name)\" $(propstring(comp.properties)), $d_prop>$children$text</$(comp.tag)>"::String
end

"""
```julia
M!(path::Component{:path}, x::Number, y::Number) -> ::String
```

---
```example

```
"""
M!(path::Component{:path}, x::Number, y::Number) = path["d"] = path["d"] * "M$x $y "

"""

"""
L!(path::Component{:path}, x::Number, y::Number) = path["d"] = path["d"] * "L$x $y "

"""

"""
Z!(path::Component{:path}) = path["d"] = path["d"] * "Z"

"""

"""
function Q!(path::Component{:path}, x::Number, a1::Number, a2::Number, y::Number)
    path[:d] = path[:d] * "Q$x, $a1 $a2, $y "
end

"""

"""
function C!(x::Number, y::Number, a1::Number, a2::Number, a4::Number)
    path[:d] = path[:d] * "C$x,$y $a1, $a2 $a3, $a4 "
end

"""
```julia
size(comp::Component{<:Any}) -> ::Tuple{Int64, Int64}
```
Returns the x/y dimensions of any SVG `Component` with a `size` binding. 
Position and size for different SVGComponents is stored differently, so this 
    `Function` is used with multiple dispatch to get the size of any component.
`ToolipsSVG` provides bindings for`Component{:rect}`, `Component{:circle}`, `Component{:star}`, and `Component{:polyshape}`.
Size may also be set with dispatch using `set_size!`.
---
```example

```
- See also: `position`, `star`, `polyshape`, `Component`, `set_size!`, `set_position!`
"""
size(comp::Component{<:Any}) = (comp[:width], comp[:height])
size(comp::Component{:rect}) = (comp[:width], comp[:height])
size(comp::Component{:circle}) = (comp[:r], comp[:r])

"""
```julia
get_position(comp::Component{<:Any}) -> ::Tuple{Int64, Int64}
```
Similar to `size(comp::Component{<:Any})`, this `Function` is 
used to get the position of many different SVG component types 
in the same way. Also like size, position may also be set with 
`set_position!`.
---
```example

```
- See also: `size(<:ToolipsSVG.ToolipsServables.AbstractComponent)`, `set_size!`, `set_position!`
"""
get_position(comp::Component{<:Any}) = (comp[:x], comp[:y])
get_position(comp::Component{:circle}) = (comp[:cx], comp[:cy])

"""
```julia
set_size!(comp::Component{<:Any}, w::Number, h::Number) -> ::Number
```
`set_size` sets the size of the `Component` `comp`, can be used 
with multiple dispatch to create consistent size keying for multiple 
    SVG element types.
---
```example

```
- See also: `position`, `star`, `polyshape`, `Component`
"""
set_size!(comp::Component{<:Any}, w::Number, h::Number) = comp.properties[:width], comp.properties[:height] = w, h
set_size!(comp::Component{:circle}, w::Number, h::Number) = begin
    comp.properties[:r] = w
end

"""
```julia
set_position!(comp::Component{<:Any}, x::Number, y::Number) -> ::Number
```
Sets the position of `comp` to `x` and `y`.
---
```example

```
- See also: `position`, `star`, `polyshape`, `Component`
"""
set_position!(comp::Component{<:Any}, x::Number, y::Number) = comp.properties[:x], comp.properties[:y] = x, y

set_position!(comp::Component{:circle}, x::Number, y::Number) = comp.properties[:cx], comp.properties[:cy] = x, y

const text = Component{:text}
const image = Component{:image}
const circle = Component{:circle}
const rect = Component{:rect}
const path = Component{:path}
const line = Component{:line}
const ellipse = Component{:ellipse}
const polyline = Component{:polyline}
const polygon = Component{:polygon}
const use = Component{:use}
const g = Component{:g}

"""
### abstract type SVGShape{T <: Any}
The `SVGShape` is used as a parameteric type to represent shape. 
This is used to create functions where a shape might want to be 
provided in an argument. For instance, `set_shape!` uses the `SVGShape` 
to turn a `Component` into a different `Component`, of a different shape, 
with the same `size` and `position`
- See also: 
"""
abstract type SVGShape{T <: Any} end

"""
```julia
get_shape(comp::Component{<:Any}) -> ::SVGShape{<:Any}
---
```example

```
"""
get_shape(comp::Component{<:Any}) = SVGShape{typeof(comp).parameters[1]}

"""
```julia
set_shape!(comp::Component{<:Any}, into::Symbol; args ...)
---
`set_shape!` is used to turn a shape into another shape with the same 
size and position.

```example

```
"""
set_shape!(comp::Component{<:Any}, into::Symbol; args ...) = set_shape!(comp, SVGShape{into}; args ...)

function set_shape!(shape::Component{:circle}, into::Type{SVGShape{:star}}; outer_radius::Number = 5, inner_radius::Number = 3,
    points::Number = 5, args ...)
    s = ToolipsSVG.get_position(shape)
    star(shape.name, x = s[1], y = s[2], outer_radius = outer_radius, inner_radius = inner_radius, points = points)::Component{:star}
end

function set_shape!(shape::Component{:circle}, into::Type{SVGShape{:square}}; outer_radius::Number = 5, inner_radius::Number = 3,
    points::Number = 5, args ...)
    xy = ToolipsSVG.get_position(shape)
    rad = shape[:r]
    rect(randstring(4), x = xy[1] - rad, y = xy[2] - rad, width = rad, height = rad)::Component{:rect}
end

function set_shape!(comp::Component{:circle}, into::Type{SVGShape{:shape}}; sides::Number = 3, r::Number = 5, angle::Number = 2 * pi / sides, args ...)
    s = ToolipsSVG.get_position(comp)
    shape(comp.name, x = s[1], y = s[2], sides = sides, r = r, angle = angle)::Component{:shape}
end

function star_points(x::Number, y::Number, points::Number, outer_radius::Number, inner_radius::Number, 
    angle::Number)
    step = pi / points
    join([begin
        r = e%2 == 0 ? inner_radius : outer_radius
        posx = x + r * cos(i)
        posy = y + r * sin(i)
        "$posx $posy"
    end for (e, i) in enumerate(range(0, step * (points * 2), step = step))], ",")::String
end

"""
```julia
star(name::String, p::Pair{String, <:Any} ...; x::Number = 0, y::Number = 0, points::Number = 5, 
outer_radius::Number = 100, inner_radius::Number = 200, angle::Number = pi / points, args ...) -> ::Component{:star}
```
Builds a special `SVG` `:star` `Component`. This is a `:polygon` tagged element 
that is specially typed in order to become a composable star. Similarly, `ToolipsSVG` also provides the 
`polyshape` `Component`.
---
```example

```
"""
function star(name::String, p::Pair{String, <:Any} ...; x::Number = 0, y::Number = 0, points::Number = 5, 
    outer_radius::Number = 100, inner_radius::Number = 200, angle::Number = pi / points, args ...)
    spoints = star_points(x, y, points, outer_radius, inner_radius, angle)
    comp::Component{:star} = Component{:star}(name, "points" => "'$spoints'", p ...; tag = "polygon", args ...)
    push!(comp.properties, :x => x, :y => y, :r => outer_radius, :angle => angle, 
    :np => points, :ir => inner_radius)
    comp::Component{:star}
end

set_position!(comp::Component{:star}, x::Number, y::Number) = begin
    pnts, angle, outer_radius, ir = comp[:np], comp[:angle], comp[:r], comp[:ir]
    spoints = star_points(x, y, pnts, outer_radius, ir, angle)
    comp["points"] = "'$spoints'"
    nothing
end

function size(comp::Component{:star})
    (comp[:r], comp[:r])
end

function shape_points(x::Number, y::Number, r::Number, sides::Number, angle::Number)
    join([begin
        posx = x + r * sin(i * angle)
        posy = y + r * cos(i * angle)
        "$posx $posy"
    end for i in 1:sides], ",")::String
end

"""
```julia
star(name::String, p::Pair{String, <:Any} ...; x::Number = 0, y::Number = 0,
sides::Number = 3, r::Number = 100, angle::Number = 2 * pi / sides, args ...) -> ::Component{:star}
```
Builds a special `SVG` `:star` `Component`. This is a `:polygon` tagged element 
that is specially typed in order to become a composable star. Similarly, `ToolipsSVG` also provides the 
`polyshape` `Component`.
---
```example

```
"""
function polyshape(name::String, p::Pair{String, <:Any} ...; x::Number = 0, y::Number = 0, 
    sides::Number = 3, r::Number = 100, angle::Number = 2 * pi / sides, args ...)
    points = shape_points(x, y, r, sides, angle)
    comp::Component{:polyshape} = Component{:polyshape}(name, "points" => "'$points'", p ...; tag = "polygon", args ...)
    push!(comp.properties, :x => x, :y => y, :r => r, :sides => sides, :angle => angle)
    comp::Component{:polyshape}
end

function size(comp::Component{:polyshape})
    (comp[:r], comp[:r])
end

export circle, path, rect, star, svg, div, tmd, g, polyshape, line, path, image, text, polyline, polygon, use, ellipse
export set_position!, get_shape, set_size!, get_position, polyshape, Component, AbstractComponent, set_shape!
export M!, L!, Z!, Q!
end # module
