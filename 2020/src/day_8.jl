# https://adventofcode.com/2020/day/8
using AdventOfCode

input = readlines("2020/data/day_8.txt")

function parse_input(line)
    inst, n = split(line)
    Symbol(inst), parse(Int, n)
end

ptr_offset(inst, n) = inst == :jmp ? n : 1
acc_offset(inst, n) = inst == :acc ? n : 0

function part_1(input)
    code = parse_input.(input)
    
    ptr, acc = 1, 0
    executed = BitSet()

    while ptr ∉ executed
        inst, n = code[ptr]
        push!(executed, ptr)
        ptr += ptr_offset(inst, n)
        acc += acc_offset(inst, n)
    end
    return acc
end
@info part_1(input)

# control flow doesn't depend on the accumulator, just the pointer operations.
# so we can treat this as a graph with (at least) two connected components.  we
# need to find all the nodes that will reach the n+1th instruction and all the
# ones that are reachable from the first

ptr_offset(inst, n) = inst == :jmp ? n : 1

function part_2(input)
    code = parse_input.(input)

    backedges = Dict{Int,Vector{Int}}()

    for (ptr, inst) in enumerate(code)
        next_ptr = ptr + ptr_offset(inst...)
        push!(get!(backedges, next_ptr, Int[]), ptr)
    end

    reachable = Set{Int}()
    frontier = [length(code)+1]
    while !isempty(frontier)
        @show current = pop!(frontier)
        push!(reachable, current)
        @show backedges[current]
        for next in backedges[current]
            if next ∉ reachable
                push!(frontier, next)
            end
        end
    end
    
end
part_2(input)



