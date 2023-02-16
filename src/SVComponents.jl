"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
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
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function circle(name::String, p::Pair{String, <:Any} ...; cx::Number = 0,
    cy::Number = 0, r::Number = 0, args ...)
    Component(name, "circle", p ..., cx = cx, cy = cy, r = r,
    args ...)::Component{:circle}
end

"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function rect(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "rect", p..., args...)::Component{:rect}
end

"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
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
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function line(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "line", p ..., args ...)
end

"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function image(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "image", p ..., args ...)
end

"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function ellipse(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "ellipse", p ..., args ...)
end

"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function polyline(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "polyline", p ..., args ...)
end

"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function polygon(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "polygon", p ..., args ...)
end

"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function use(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "use", p ..., args ...)
end

"""
**Interface**
### properties!(::Servable, ::Servable) -> _
------------------
Copies properties from s,properties into c.properties.
#### example
```

```
"""
function text(name::String, p::Pair{String, <:Any} ...; args ...)
    Component(name, "text", p ..., args ...)
end
