all_tests = []
for (root, dirs, files) in walkdir(".")
    for filename in files
        !endswith(filename, ".jl") && continue
        "runtests.jl" == filename && continue
        filepath = joinpath(root, filename)[3:end]
        !isempty(ARGS) && !any(x->startswith(filepath, x), ARGS) && continue
        push!(all_tests, filepath)
    end
end

import Test
for (idx, filepath) in enumerate(all_tests)
    numbering = string(idx, /, length(all_tests))
    Test.@testset "$numbering $filepath" begin
        include(filepath)
    end
end
