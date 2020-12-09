# https://adventofcode.com/2020/day/5
using AdventOfCode

input = readlines("2020/data/day_5.txt")

# output is essentially binary number where 'B' or 'R' are the 1s
function seat_id(seat)
    acc = 0
    for c in seat
        acc <<= 1
        acc += (c == 'B' || c == 'R')
    end
    return acc
end

function part_1(input)
    maximum(seat_id, input)
end
@info part_1(input)

function part_2(input)
    seats = sort!(map(seat_id, input))
    Δ = first(seats) - 1
    for (i,s) in enumerate(seats)
        s-i == Δ || return s-1
    end
end
@info part_2(input)
