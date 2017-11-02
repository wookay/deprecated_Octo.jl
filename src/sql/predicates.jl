import Base: ==

function ==(c::Column, s::String)::Predicate
    Predicate(equalto, c, s)
end
