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

function part_2(input)
    code = parse_input.(input)

    # a from × to matrix of edges
    edges = falses(length(code), length(code)+1)

    for (ptr, inst) in enumerate(code)
        next_ptr = ptr + ptr_offset(inst...)
        if next_ptr <= size(edges, 2)
            edges[ptr, next_ptr] = true
        end
    end

    colors = zeros(Int, length(code))

    ptr = 1
    while colors[ptr] == 0
        colors[ptr] = 1
        ptr = 
    edges
end
part_2(input)
