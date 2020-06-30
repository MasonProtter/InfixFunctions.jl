module InfixFunctions

struct InfixFunction <: Function
    name::Symbol
    operator::Function
end

InfixFunction(operator::Function) = InfixFunction(gensym(), operator)

(infix::InfixFunction)(arg₁, arg₂) = infix.operator(arg₁, arg₂)

function Base.show(io::IO, infix::InfixFunction)
    n_methods = length(methods(infix.operator))
    _methods = n_methods == 1 ? "method" : "methods"
    name = infix.name

    println(io, "$name (generic infix function with $n_methods $_methods)")
end

Base.display(infix::InfixFunction) = show(infix)

function Base.:|(arg₁, infix::InfixFunction)
    return InfixFunction(arg₂ -> infix.operator(arg₁, arg₂))
end

Base.:|(infix::InfixFunction, arg₂) = infix.operator(arg₂)

macro infix(operator::Symbol)
    return quote
        $operator::Function

        function Base.:|(arg₁, infix::typeof($operator))
            return $InfixFunction(arg₂ -> infix(arg₁, arg₂))
        end

        Base.:|(infix::typeof($operator), arg₂) = infix(arg₂)

        @info "$($operator) has been infixified"

        $operator
    end |> esc
end

end
