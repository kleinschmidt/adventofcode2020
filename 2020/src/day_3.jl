# https://adventofcode.com/2020/day/3
using AdventOfCode

input = readlines("2020/data/day_3.txt")

wrap(idx, size) = rem((idx-1), size)+1

function part_1(input, down=1, across=3)
    size_v, size_h = length(input), length(first(input))

    vs = 1:down:size_v
    hs = (wrap(h, size_h) for h in range(1, step=across, length=length(vs)))

    sum(input[v][h] == '#' for (v,h) in zip(vs, hs))
end
@info part_1(input)

function part_2(input)
    prod(part_1.(Ref(input), (1,1,1,1,2), (1,3,5,7,1)))
end
@info part_2(input)
