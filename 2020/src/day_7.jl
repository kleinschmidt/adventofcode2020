# https://adventofcode.com/2020/day/7
using AdventOfCode

input = readlines("2020/data/day_7.txt")

function parse_bags(str)
    m = match(r"([0-9]+) ([ a-z]+) bag", str)
    m.captures[2], parse(Int, m.captures[1])
end

function parse_line(line)
    m = match(r"([a-z ]*) bags? contain ([a-z0-9, ]*).", line)
    parent = m.captures[1]
    if m.captures[2] == "no other bags"
        contents = []
    else
        contents = parse_bags.(split(m.captures[2], ", "))
    end
    parent, contents
end

function part_1(input)
    backedges = Dict()
    for line in input
        parent, contents = parse_line(line)
        for c in contents
            push!(get!(backedges, first(c), []), parent)
        end
    end

    frontier = ["shiny gold"]
    visited = Set()
    while !isempty(frontier)
        current = pop!(frontier)
        @show current
        for next in get(backedges, current, [])
            @show next
            next ∈ visited || push!(frontier, next)
        end
        push!(visited, current)
    end
    return length(visited) - 1  # don't count shiny gold itself
end
@info part_1(input)

function part_2(input)
    edges = Dict()
    for line in input
        parent, contents = parse_line(line)
        if !isempty(contents)
            edges[parent] = contents
        end
    end
    
    frontier = [("shiny gold", 1)]
    total_bags = 0
    while !isempty(frontier)
        current, cur_n = pop!(frontier)
        for next in get(edges, current, [])
            color, n = next
            push!(frontier, (color, n*cur_n))
        end
        total_bags += cur_n
    end
    total_bags - 1              # again, don't count original shiny gold
end
@info part_2(input)
