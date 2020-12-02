# find invalid passwords.

input = readlines("02.input")

function parse_line(line)
    policy, password = split(line, ": ")
    range, char = split(policy, ' ')
    low, high = parse.(Int, split(range, '-'))
    return low, high, first(char), password
end
    
function isvalid(line)
    low, high, char, password = parse_line(line)
    n = sum(isequal(char), cc for cc in password)
    @show low, high, char, password, n
    return(low ≤ n ≤ high)
end

star1(input) = sum(isvalid, input)

star1(input)

function isvalid2(line)
    low, high, char, password = parse_line(line)
    return xor(password[low] == char, password[high] == char)
end

sum(isvalid2, input)
