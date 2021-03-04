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

m = mean(data)

squared_data = (data.-m).^2

scatter(squared_data, alpha = 0.5)

variance = mean((data .-m).^2)

σ = √(variance) #\sigma \sqrt

count(m - σ .< data .< (m + σ))

# can instead do array comprehension

#71 percent within 1 standard deviationl
count([m - σ < x < (m + σ) for x in data]) / length(data)

scatter(data, alpha = 0.2)

using Statistics

#standard deviation of mean
std(data)


# generic random walk function that works with discrete and continuous distributions
#can pass function as argument
function walk(N, jump)

    x = 0
    for i in 1:N
        x += jump()
    end

    return x
end

discrete_jump() = rand((-1,+1))
continuous_jump() = randn()

# pass one of these two functioins as an argument
walk(10, continuous_jump)

#user defined/custom types -- composite types in Julia
#struct creates an immutable though

struct MyDisreteRandomWalker
    x::Int # type annotation: x is of type Integer
end

# box with random data inside
# to make an object of this type call a function of the struct

w = MyDisreteRandomWalker(10)

w.x # variable that lives inside the object w

#here we can create a mutable structure
mutable struct MyDisreteRandomWalker2
    x::Int
end

function jump!(w::MyDisreteRandomWalker2)
    w.x += rand((-1, +1))
    return w
end

w = MyDisreteRandomWalker2(10)

jump!(w)

function walk!(w, N)

    for i in 1:N
        jump!(w)
    end

end

# outer constructor, outside the type
# creating a new method of this function
MyDisreteRandomWalker2() = MyDisreteRandomWalker2(0)

w = MyDisreteRandomWalker2()
