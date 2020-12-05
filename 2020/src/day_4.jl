# https://adventofcode.com/2020/day/4
using AdventOfCode

input = read("2020/data/day_4.txt", String)

function is_valid(passport::AbstractString)
    fields = split(passport, r"\s")
    pp = Dict(Pair(split(f, ':')...) for f in fields)

    mandatory_keys = Set(("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid")) # not "cid"

    isempty(setdiff(mandatory_keys, keys(pp)))
end

function part_1(input)
    sum(is_valid.(split(chomp(input), "\n\n")))
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)
