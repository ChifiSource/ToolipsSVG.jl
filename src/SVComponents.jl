function circle(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "circle", p ..., args ...)::Component{:circle}
end

function path(name::String, p::Pair{String, <:Any} ...; d = "", args ...)
    comp = Component(name, "path", p ..., args ...)::Component{:path}
    comp["d"] = d
    comp::Component{:path}
end

function line(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "line", p ..., args ...)
end

function image(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "image", p ..., args ...)
end

function ellipse(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "ellipse", p ..., args ...)
end

function polyline(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "polyline", p ..., args ...)
end

function polygon(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "polygon", p ..., args ...)
end

function use(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "use", p ..., args ...)
end

function text(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "text", p ..., args ...)
end
