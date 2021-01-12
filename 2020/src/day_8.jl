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

ptr_offset_alt(inst, n) = inst == :nop ? n : 1

function find_backedges(code)
    backedges = Dict{Int,Vector{Int}}()

    for (ptr, inst) in enumerate(code)
        next_ptr = ptr + ptr_offset(inst...)
        push!(get!(backedges, next_ptr, Int[]), ptr)
    end

    return backedges
end

function reachable(from, backedges)
    reachable = Set{Int}()
    frontier = [from]
    while !isempty(frontier)
        @show current = pop!(frontier)
        push!(reachable, current)
        @show get(backedges, current, ())
        for next in get(backedges, current, ())
            if next ∉ reachable
                push!(frontier, next)
            end
        end
    end

    return reachable
end

function part_2(input)
    code = parse_input.(input)
    terminal = length(code)+1

    backedges = find_backedges(code)
    dests = reachable(terminal, backedges)

    ptr, acc, switched = 1, 0, false
    while ptr != terminal
        @show ptr, acc, code[ptr]
        inst, n = code[ptr]
        acc += acc_offset(inst, n)
        ptr_alt = ptr + ptr_offset_alt(inst, n)
        if !switched && ptr_alt ∈ dests
            @show ptr_alt
            switched = true
            ptr = ptr_alt
        else
            ptr += ptr_offset(inst, n)
        end
    end
    return acc
end
part_2(input)

