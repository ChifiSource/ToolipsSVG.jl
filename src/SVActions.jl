grow!(cm::ComponentModifier, c::Component{:circle}, percent::String) = begin
    # The `percent` value ACTUALLY needs to be the c["r"] property times the
    #    number as a percentage :)
    # this is mainly just a placeholder for this file !
    cm[c] = "r" => percent
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
