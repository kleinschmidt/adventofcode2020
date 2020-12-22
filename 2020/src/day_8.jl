# https://adventofcode.com/2020/day/8
using AdventOfCode

input = readlines("2020/data/day_8.txt")

function parse_input(line)
    inst, n = split(line)
    Symbol(inst), parse(Int, n)
end

function part_1(input)
    code = parse_input.(input)
    
    ptr, acc = 1, 0
    executed = BitSet()

    while ptr ∉ executed
        inst, n = code[ptr]
        push!(executed, ptr)
        if inst == :acc
            acc += n
            ptr += 1
        elseif inst == :jmp
            ptr += n
        elseif inst == :nop
            ptr += 1
        else
            error("unknown instruction: $inst $n")
        end
    end
    return acc
end
@info part_1(input)


function part_2(input)
    nothing
end
@info part_2(input)
