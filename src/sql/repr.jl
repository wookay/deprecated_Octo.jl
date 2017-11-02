# module Octo.SQL

import Base: getindex

spacejoin(phrase) = join(phrase, ' ')

function getindex(::typeof(repr), tup::NamedTuple)
    string(tup[:__octo_table].name)
end

function getindex(::typeof(repr), s::Select)
    columns = map(s.columns) do c
        if c isa typeof(*)
            *
        elseif c isa Column
            c.name
        end
    end
    ["SELECT", join(columns)] |> spacejoin
end

function getindex(::typeof(repr), f::From)
    phrase = ["FROM", f.table.name]
    f.as isa Symbol && push!(phrase, "AS", f.as)
    phrase |> spacejoin
end

function getindex(::typeof(repr), w::Where)
    ["WHERE", repr[w.predicates]] |> spacejoin
end

function getindex(::typeof(repr), c::Column)
    c.name
end

function getindex(::typeof(repr), s::String)
    string("'", s, "'")
end

function getindex(::typeof(repr), ::Type{Base.EqualTo})
    '='
end

function getindex(::typeof(repr), preds::Vector{Predicate})
    predicates = map(preds) do pred
        (repr[pred.first], repr[pred.op], repr[pred.second]) |> spacejoin
    end
    predicates |> spacejoin
end

function Base.typed_hcat(::typeof(repr), s::Select, f::From)
    getindex.(repr, (s, f)) |> spacejoin
end

function Base.typed_hcat(::typeof(repr), s::Select, f::From, w::Where)
    getindex.(repr, (s, f, w)) |> spacejoin
end
