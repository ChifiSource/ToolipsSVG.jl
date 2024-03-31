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
using Toolips
import Base: size, reshape
import Toolips: AbstractComponent, Servable, write!, AbstractConnection

function write!(c::AbstractConnection, svp::Component{:path})
    open_tag::String = "<$(svp.tag) id=$(svp.name)"
    text::String = ""
    [begin
        special_keys::Vector{Any} = [:text, :children, "d"]
        if ~(property in special_keys)
            prop::String = string(svp.properties[property])
            propkey::String = string(property)
           open_tag = open_tag * " $propkey=$prop"
        else
            if property == :text
                text = svp.properties[property]
            elseif property == "d"
                open_tag = open_tag * " d=\"$(svp["d"])\""
            end
        end
    end for property in keys(svp.properties)]
    write!(c, open_tag * ">")
    if length(svp.properties[:children]) > 0
        write!(c, svp.properties[:children])
   end
   write!(c, "$text</$(svp.tag)>")
   write!(c, svp.extras)
end

"""

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

size(comp::Component{<:Any}) = (comp[:width], comp[:height])
size(comp::Component{:rect}) = (comp[:width], comp[:height])
size(comp::Component{:circle}) = (comp[:r], comp[:r])

position(comp::Component{<:Any}) = (comp[:x], comp[:y])
position(comp::Component{:circle}) = (comp[:cx] + comp[:r], comp[:cy] + comp[:r])

set_size!(comp::Component{<:Any}, w::Int64, h::Int64) = comp[:width], comp[:height] = w, h
set_size!(comp::Component{:circle}, w::Int64, h::Int64) = comp[:r] = width

set_position!(comp::Component{<:Any}, x::Number, y::Number) = comp[:x], comp[:y] = x, y

set_position!(comp::Component{:circle}, x::Number, y::Number) = comp[:cx], comp[:cy] = x, y

g(name::String, styles::Pair{String, String} ...; args ...) = begin
    comp::Component{:g} = Component(name, "g", args ...)
    if length(styles) != 0
        style!(comp, styles ...)
    end
    comp::Component{:g}
end

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

struct SVGShape{T <: Any} end

get_shape(comp::Component{<:Any}) = SVGShape{typeof(comp).parameters[1]}()

reshape(comp::Component{<:Any}, into::Symbol; args ...) = reshape(shape, GattinoShape{into}(); args ...)

function star_points(x::Int64, y::Int64, points::Int64, outer_radius::Int64, inner_radius::Int64, 
    angle::Number)
    step = pi / points
    join([begin
        r = e%2 == 0 ? inner_radius : outer_radius
        posx = x + r * cos(i)
        posy = y + r * sin(i)
        "$posx $posy"
    end for (e, i) in enumerate(range(0, step * (points * 2), step = step))], ",")::String
end

function star(name::String, p::Pair{String, <:Any} ...; x = 0::Int64, y = 0::Int64, points::Int64 = 5, 
    outer_radius::Int64 = 100, inner_radius::Int64 = 200, angle::Number = pi / points, args ...)
    spoints = star_points(x, y, points, outer_radius, inner_radius, angle)
    comp = Component(name, "star", "points" => "'$spoints'", p ..., args ...)
    comp.tag = "polygon"
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

function shape_points(x::Int64, y::Int64, r::Int64, sides::Int64, angle::Number)
    join([begin
        posx = x + r * sin(i * angle)
        posy = y + r * cos(i * angle)
        "$posx $posy"
    end for i in 1:sides], ",")::String
end

function shape(name::String, p::Pair{String, <:Any} ...; x::Int64 = 0, y::Int64 = 0, 
    sides::Int64 = 3, r::Int64 = 100, angle::Number = 2 * pi / sides, args ...)
    points = shape_points(x, y, r, sides, angle)
    comp = Component(name, "shape", "points" => "'$points'", p ..., args ...)
    comp.tag = "polygon"
    push!(comp.properties, :x => x, :y => y, :r => r, :sides => sides, :angle => angle)
    comp::Component{:shape}
end

function size(comp::Component{:shape})
    (comp[:r], comp[:r])
end

function reshape(con::AbstractContext, layer::String, into::Symbol; args ...)
    shape = GattinoShape{into}()
    con.window[:children][layer][:children] = [reshape(comp, shape, args ...) for comp in con.window[:children][layer][:children]]
end

function reshape(shape::Component{:circle}, into::SVGShape{:star}; outer_radius::Int64 = 5, inner_radius::Int64 = 3,
    points::Int64 = 5, args ...)
    s = ToolipsSVG.position(shape)
    star(shape.name, x = s[1], y = s[2], outer_radius = outer_radius, inner_radius = inner_radius, points = points)::Component{:star}
end

function reshape(shape::Component{:circle}, into::SVGShape{:square}; outer_radius::Int64 = 5, inner_radius::Int64 = 3,
    points::Int64 = 5, args ...)
    xy = ToolipsSVG.position(shape)
    rad = shape[:r]
    rect(randstring(4), x = xy[1] - rad, y = xy[2] - rad, width = rad, height = rad)::Component{:rect}
end

function reshape(comp::Component{:circle}, into::SVGShape{:shape}; sides::Int64 = 3, r::Int64 = 5, angle::Number = 2 * pi / sides, args ...)
    s = ToolipsSVG.position(comp)
    shape(comp.name, x = s[1], y = s[2], sides = sides, r = r, angle = angle)::Component{:shape}
end



export circle, path, rect, star, shape, set_position!
export M!, L!, Z!, Q!
end # module
