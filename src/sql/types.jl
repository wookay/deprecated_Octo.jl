# module Octo.SQL

struct Table
    name::Symbol
end

struct Column
    table::Table
    name::Symbol
end

# clauses
abstract type Clause end

struct Select <: Clause
    columns::Vector{Union{Column,typeof(*)}}
end

struct From <: Clause
    table::Table
    as::Union{Void, Symbol}
    From(table::Table) = new(table, nothing)
    From(table::Table, as::Symbol) = new(table, as)
end

struct Predicate
    op
    first
    second
end

struct Where <: Clause
    predicates::Vector{Predicate}
end
