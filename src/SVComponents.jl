"""
**ToolipsSVG**
### g(name::String, styles::Pair{String, String} ...; args ...) -> ::Component{:g}
------------------
Creates a `g` Component. Note that `styles` replaces the properties argumeent
for this method.
#### example
```

```
"""
g(name::String, styles::Pair{String, String} ...; args ...) = begin
    comp::Component{:g} = Component(name, "g", args ...)
    if length(styles) != 0
        style!(comp, styles ...)
    end
    comp::Component{:g}
end

"""
**ToolipsSVG**
### text(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:text}
------------------
Creates a `text` Component.
#### example
```

```
"""
function text(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "text", p ..., args ...)
end

"""
**ToolipsSVG**
### animate(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:animate}
------------------
Creates an `animate` Component.
#### example
```

```
"""
function animate(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "animate", p ..., args ...)
end

"""
**ToolipsSVG**
### image(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:image}
------------------
Creates an `image` Component.
#### example
```

```
"""
function image(name::String, p::Pair{String, <:Any} ...)
    Component(name, "image", p ..., args ...)
end

"""
**ToolipsSVG**
### circle(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:circle}
------------------
Creates an `circle` Component.
#### example
```

```
"""
function circle(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "circle", p ..., args ...)::Component{:circle}
end

"""
**ToolipsSVG**
### rect(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:rect}
------------------
Creates an `rect` Component.
#### example
```

```
"""
function rect(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "rect", p..., args...)::Component{:rect}
end

"""
**ToolipsSVG**
### path(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:path}
------------------
Creates a `path` Component.
#### example
```

```
"""
function path(name::String, p::Pair{String, <:Any} ...; d = "", args ...)
    comp = Component(name, "path", p ..., args ...)::Component{:path}
    comp["d"] = d
    comp::Component{:path}
end

"""
**ToolipsSVG**
### path(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:path}
------------------
Creates a `path` Component.
#### example
```

```
"""
function path(f::Function, name::String, p::Pair{String, <:Any} ...; args ...)
    comp = Component(name, "path", p ..., args ...)::Component{:path}
    comp["d"] = ""
    f(comp)
    comp::Component{:path}
end


"""
**ToolipsSVG**
### line(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:line}
------------------
Creates a `line` Component.
#### example
```

```
"""
function line(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "line", p ..., args ...)
end

"""
**ToolipsSVG**
### ellipse(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:ellipse}
------------------
Creates an `ellipse` Component.
#### example
```

```
"""
function ellipse(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "ellipse", p ..., args ...)
end

"""
**ToolipsSVG**
### polyline(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:polyline}
------------------
Creates a `polyline` Component.
#### example
```

```
"""
function polyline(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "polyline", p ..., args ...)
end

"""
**ToolipsSVG**
### polygon(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:polygon}
------------------
Creates a `polygon` Component.
#### example
```

```
"""
function polygon(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "polygon", p ..., args ...)
end

"""
**ToolipsSVG**
### use(name::String, p::Pair{String, String} ...; args ...) -> ::Component{:use}
------------------
Creates a `use` Component.
#### example
```

```
"""
function use(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "use", p ..., args ...)
end



size(comp::Component{<:Any}) = (comp[:width], comp[:height])

coords(comp::Component{<:Any}) = (comp[:x], comp[:y])

size(comp::Component{:circle}) = (comp[:r], comp[:r])

coords(comp::Component{:circle}) = (comp[:cx] + com[:r], comp[:cy] + com[:r])

size(comp::Component{:rect}) = (comp[:width], comp[:height])

coords(comp::Component{:rect}) = (comp[:x], comp[:y])
