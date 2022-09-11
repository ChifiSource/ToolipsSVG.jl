module ToolipsSVG
using Toolips
using ToolipsSession
import Toolips: AbstractComponent, Servable, write!
import ToolipsSession: on
import Base: getindex, setindex!, length, size
include("SVComponents.jl")
include("SVActions.jl")
export circle
end # module
