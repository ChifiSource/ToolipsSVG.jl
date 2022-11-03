function circle(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "circle", p ..., args ...)::Component{:circle}
end

function path(name::String, p::Pair{String, <:Any} ...; d = "", args ...)
    comp = Component(name, "path", p ..., args ...)::Component{:path}
    comp["d"] = d
    comp::Component{:path}
end
