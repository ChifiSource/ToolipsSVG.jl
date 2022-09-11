grow!(cm::ComponentModifier, c::Component{:circle}, percent::String) = begin
    # The `percent` value ACTUALLY needs to be the c["r"] property times the
    #    number as a percentage :)
    # this is mainly just a placeholder for this file !
    cm[c] = "r" => percent
end
moveto!(path::Component{:path}, x::Int64, y::Int64) = path[:d] = path.d * "M$x $y "

lineto!(path::Component{:path}, x::Int64, y::Int64) = path[:d] = path.d * "L$x $y "

closepath!(path::Component{:path}) = path[:d] =path[:d] * "Z"


function curveto_q!(path::Component{:path}, x::Int64, a1::Int64, a2::Int64, y::Int64)
    path[:d] = path[:d] * "Q$x, $a1 $a2, $y "
end
