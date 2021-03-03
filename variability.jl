#variability

#bringing back our random walk functions

function walk(num_steps)

    x = 0
    for i in 1:num_steps
        x += rand((-1,+1))
    end

    return x
end

experiment(num_steps, num_walks) = [walk(num_steps) for i in 1:num_walks]

data = experiment(20, 1000)

#transposing operator
data'

using StatsBase

counts = countmap(data)

using Plots

histogram(data, bins = 20, normed=true)

# can extract the weight from the object
h = fit(Histogram, data)

# normalized weights
# . calls object within object
h.weights / sum(h.weights)

# mean

mean(data)
sum(data) / length(data)

# spread from mean

scatter(data)
hline!([mean(data)], lw = 3, ls =:dash, c=:purple)

centered_data = data.-mean(data)
#de-meaning subtracting mean from data

#mean of centered data is true mean
mean(centered_data)


nextfloat(1.0) - 1.0

# machine epsilon for double precision -- Float64 weird

#spread from mean
abs_data = abs.(centered_data)

scatter(abs_data, alpha = 0.2)
hline!([mean(abs_data)], lw=3, ls=:dash, c =:purple)

abs_data .< mean(abs_data)

# half the points are less than mean
count(abs_data .< mean(abs_data)) / length(abs_data)

# half the points are less than mean

# julia will evaluate multiplication of variable and number
# side by side
# 2x evaluates as 2 * x
count(abs_data .< 2mean(abs_data)) / length(abs_data)


#more robust is mean of squared error

squared_data = data.^2

scatter(squared_data, alpha = 0.5)
