module ToolipsSVG
using Toolips
using ToolipsSession
import Toolips: AbstractComponent, Servable, write!, AbstractConnection
import ToolipsSession: on
import Base: getindex, setindex!, length, size

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

include("SVComponents.jl")
include("SVActions.jl")
export circle, path
export grow!, moveto!, lineto!, closepath!
end # module
