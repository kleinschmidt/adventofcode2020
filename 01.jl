input = parse.(Int, readlines("01.input"))

function star1(input)
    for i in 1:length(input)
        for j in i+1:length(input)
            if input[i]+input[j] == 2020
                return input[i]*input[j]
            end
        end
    end
end

star1(input)

function star2(input)
    for i in 1:length(input)
        for j in i+1:length(input)
            for k in j+1:length(input)
                if input[i]+input[j]+input[k] == 2020
                    return input[i]*input[j]*input[k]
                end
            end
        end
    end
end

star2(input)
