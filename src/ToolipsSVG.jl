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

M!(path::Component{:path}, x::Number, y::Number) = path["d"] = path["d"] * "M$x $y "

L!(path::Component{:path}, x::Number, y::Number) = path["d"] = path["d"] * "L$x $y "

Z!(path::Component{:path}, x::Number, y::Number) = path["d"] = path["d"] * "Z"

function Q!(path::Component{:path}, x::Number, a1::Number, a2::Number, y::Number)
    path[:d] = path[:d] * "Q$x, $a1 $a2, $y "
end

function C!(x::Number, y::Number, a1::Number, a2::Number, a4::Number)
    path[:d] = path[:d] * "C$x,$y $a1, $a2 $a3, $a4 "
end

include("SVComponents.jl")

export circle, path, rect
export M!, L!, Z!, Q!
end # module
