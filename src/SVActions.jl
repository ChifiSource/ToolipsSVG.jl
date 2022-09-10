grow!(cm::ComponentModifier, c::Component{:circle}, percent::String) = begin
    # The `percent` value ACTUALLY needs to be the c["r"] property times the
    #    number as a percentage :)
    # this is mainly just a placeholder for this file !
    cm[c] = "r" => percent
end
