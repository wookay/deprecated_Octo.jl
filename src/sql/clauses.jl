function SELECT(::typeof(*))
    Select([*])
end

function SELECT(c::Column)
    Select([c])
end

function FROM(tup::NamedTuple)
    From(tup[:__octo_table])
end

function FROM(; kwargs...)
    @assert 1 == length(kwargs)
    (k, v) = first(kwargs)
    From(v[:__octo_table], k)
end

function WHERE(pred::Predicate)
    Where([pred])
end
