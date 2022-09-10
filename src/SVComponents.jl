function circle(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "circle", p ..., args ...)::Component{:circle}
end

function circle(name::String, x::Any, y::Any, r::Any)
    circle(name, cx = x, cy = y, r = r, stroke = "black", "stroke-width" => 5)
end


function circle(name::String, x::Any, y::Any, z::Any, r::Any)

end
