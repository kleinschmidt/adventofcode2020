# https://adventofcode.com/2020/day/4
using AdventOfCode

input = read("2020/data/day_4.txt", String)

mandatory_keys = Set(("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid")) # not "cid"

function is_valid(passport::AbstractString)
    fields = split(passport, r"\s")
    pp = Dict(Pair(split(f, ':')...) for f in fields)
    isempty(setdiff(mandatory_keys, keys(pp)))
end

function part_1(input)
    sum(is_valid.(split(chomp(input), "\n\n")))
end
@info part_1(input)

validators = Dict([
    "byr" => x -> 1920 ≤ parse(Int, x) ≤ 2002,
    "iyr" => x -> 2010 ≤ parse(Int, x) ≤ 2020,
    "eyr" => x -> 2020 ≤ parse(Int, x) ≤ 2030,
    "hgt" => x -> begin
        m = match(r"([0-9]+)(in|cm)", x)
        hgt = parse(Int, m.captures[1])
        unit = m.captures[2]
        if unit == "cm"
            150 ≤ hgt ≤ 193
        elseif unit == "in"
            59 ≤ hgt ≤ 76
        else
            false
        end
    end,
    "hcl" => contains(r"^#[0-9a-f]{6}$"),
    "ecl" => in(Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])),
    "pid" => contains(r"^[0-9]{9}$"),
])

function is_valid2(passport::AbstractString)
    fields = split(passport, r"\s")
    ks = Set(AbstractString[])
    for f in fields
        k, v = split(f, ':')
        k == "cid" && continue
        valid = try
            validators[k](v)
        catch e
            false
        end
        if !valid
            println("$k invalid: \"$v\"")
            return false
        end
        push!(ks, k)
    end
    return isempty(setdiff(keys(validators), ks))
end

function part_2(input)
    passports = split(chomp(input), "\n\n")
    sum(is_valid2, passports)
end
@info part_2(input)
