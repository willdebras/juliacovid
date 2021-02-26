# modeling random agents moving in space
# brownian motion as motion in random path
# fundamental model in bio, chem reactant, jet noise in engineering

# expensive tto simulate collisions
# instead sim ranndom kicks using random numberss

# gennerate jumps +-1 with uniform probability

# short func
jump() = rand((-1, +1)) # use a tuple (ordered pair)

r = rand(Bool) # random boolean and then convert to Int
Int(r)

# random walk as a seq of random jumps
# array comprehension to gen array of jumps
[jump() for i in 1:10]

function walk(n)
    x = 0
    for i in 1:n
        x += jump() # x = x + jump(), updating by adding
    end

    return x

end


walk(10)

function trajectory(n)
    x = 0
    #xs = Int64[x] #this array can only hold Int
    xs = [x] #giving initial value declares type

    for i in 1:n
        x += jump() # x = x + jump(), updating by adding
        push!(xs, x)
    end

    return xs

end

traj = trajectory(100)

using Plots

plot(traj, m=:O)
hline!([0], ls =:dash) #add horizontal line to plot at 0, need vec of pos's


num_walkers = 10
num_steps = 100

p = plot() #empty plot
for i in 1:num_walkers
    traj = trajectory(num_steps)
    plot!(traj)

end

p

# runs each walker individually,
# can instead do each step at a time
# n walkers available at once, make each take a step
# precompute then plot

# can create a vector of path aarrays
n = 50
trajs = [trajectory(n)]
#append would add multiple elements to vector
#push adds a single object (an array/vector) to the vector
push!(trajs, trajectory(n))
trajs[1]
trajs[2]

num_walkers = 10_000

#gives a vectory of vectors
walkers = [trajectory(n) for i in 1:num_walkers]

# get all values at time n

[trajs[end] for trajs in walkers] #last element in vector of vectors

# get a t = 10
[trajs[10] for trajs in walkers]

# convert vector of vectors into a matrix

#use each element of object as argument in function
hcat(walkers...) # "splat", "star" in python/r

#reduce hcat more efficient

walkers_matrix = reduce(hcat, walkers)

# last position of all, last rows, all columns
final_positions = walkers_matrix[end,:]

using StatsBase

counts = countmap(final_positions)

scatter(counts)

# can think of 10,000 individual walkers
# or the probability of a single walker, produces gaussian/normal dist
