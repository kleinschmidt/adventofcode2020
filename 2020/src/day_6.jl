# https://adventofcode.com/2020/day/6
using AdventOfCode

input = readlines("2020/data/day_6.txt")

qset(line) = BitSet(Int(c) for c in line)

function part_1(input)
    acc = BitSet()
    tot = 0
    for line in input
        if isempty(line)
            tot += length(acc)
            empty!(acc)
        else
            union!(acc, qset(line))
        end
    end
    return tot + length(acc)
end

test_input = split("""
abc

a
b
c

ab
ac

a
a
a
a

b
""", '\n')

part_1(test_input) == 11


@info part_1(input)

fullset = BitSet(Int(c) for c in 'a':'z')

function part_2(input)
    acc = copy(fullset)
    tot = 0
    for line in input
        if isempty(line)
            tot += length(acc)
            union!(acc, fullset)
        else
            intersect!(acc, qset(line))
        end
    end
    return tot + length(acc)
end

@info part_2(input)
