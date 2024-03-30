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
import Base: size
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

export circle, path, rect
export M!, L!, Z!, Q!
end # module
