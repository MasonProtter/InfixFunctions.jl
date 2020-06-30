# InfixFunctions

Julia infix function *hack*, based on this Python hack:

* http://code.activestate.com/recipes/384122-infix-operators

***

# Installation

```julia
pkg> add https://github.com/MasonProtter/InfixFunctions.jl
```

# Usage

```julia
julia> using InfixFunctions

julia> foo(x, y) = (x - y)/((x + y)/2)
foo (generic function with 1 method)

julia> foo(x::Int, y::Int) = 2(x - y)//(x + y)
foo (generic function with 2 methods)

julia> @infix foo
[ Info: foo has been infixified
foo (generic function with 2 methods)

julia> 1 |foo| 2
-2//3

julia> 1.0 |foo| 2
-0.6666666666666666

julia> @infix div
[ Info: div has been infixified
div (generic function with 54 methods)

julia> 10 |div| 5
2
```
