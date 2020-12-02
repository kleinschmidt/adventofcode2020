# find invalid passwords.

input = readlines("02.input")

function isvalid(line)
    policy, password = split(line, ": ")
    range, char = split(policy, ' ')
    low, high = parse.(Int, split(range, '-'))

    n = sum(isequal(first(char)), cc for cc in password)
    @show low, high, char, password, n
    return(low ≤ n ≤ high)
end

star1(input) = sum(isvalid, input)

star1(input)
