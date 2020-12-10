# https://adventofcode.com/2020/day/10
using AdventOfCode

input = readlines("2020/data/day_10.txt")

function countmap(x)
    counts = Dict{eltype(x),Int}()
    for xx in x
        counts[xx] = get(counts, xx, 0) + 1
    end
    return counts
end

function part_1(input)
    joltages = sort!(parse.(Int, input))
    push!(joltages, joltages[end]+3)
    pushfirst!(joltages, 0)
    counts = countmap(diff(joltages))
    counts[3] * counts[1]
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)
