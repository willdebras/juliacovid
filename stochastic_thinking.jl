# stochastic thinking

# add new values to extend data

v = [1.0]

#push adds data, ! changes object
push!(v, 7.0)


function run_infection(I_0, λ, T=20)

    # 1 element vector
    # Is referring to vector of I
    Is = [I_0]
    I = I_0

    for n in 1:T-1

        # just our rate * value
        I_next = λ * I
        # but we modify vector in place to include current I
        push!(Is, I_next)

        #update I
        I = I_next

    end

    return(Is)

end

run_infection(1.0, 1.1)

#using seeds with rand()

using Random

# mechanism to get repeatable random numbers
Random.seed!(3);


rand(10)

r = rand(100)

using Plots

# returns multiplicative identity.
# in this case we broadcast to see distribution
scatter(r, 0.5 .* one.(r), ylim = (0,1))

# events with probability
# Bernoulli trial - weighted coin, essentially

#ternary operator here

function bernoulli(p)

    r = rand()

    #if condition, return true, else false
    #r < p ? true : false

    #comparisons return boolean though, so just:

    return r < p

end

trials = [bernoulli(.25) for i in 1:100]


# count falses by iterating == op
count(trials .== false)


count(trials)

function experiment(p, N=100)
    trials = [bernoulli(p) for i in 1:N]
    return(count(trials))
end

experiment(.25)


# monte carlo simulations



function run_experiment(p, N, num_expts)

    results = [experiment(p, N) for i in 1:num_expts]

    return results

end

test = run_experiment(0.25, 20, 10000)

# probability distribution of random variable


scatter(results)

# probability that X = x = proportion of time that the result was x
# calculate proportion of time = p
# could use vector or dict

count(results.==25)

maximum(results) # max calculates maximum of arguments
minimum(results)

l = maximum(results) + 1 #+1 in case we got a zero

counts = zeros(l);

#score takes on value of x, for iteration

for score in results[1:10] # for i in 1:length(x)
    @show score

end

function count_them(results)

    counts = zeros(Int, maximum(results) + 1)

    for score in results # for i in 1:length(x)
        counts[score+1] += 1 # increment by 1

    end

    return counts

end

count_them(test)

using LaTeXStrings

#This is a frequency distribution

plot(0:maximum(results), counts, m=:O)
xlabel!(L"n")
ylabel!("frequency of having n heads")

# Probability is relative frequency
# Divide by number of trials

# new frequency with great N

@time data = count_them(run_experiment(0.25, 20, 10^7))

# took ~3.5 seconds locally

#indiv probabilities


probs = data ./ 10^7 # num_expts

# sum of probabilities is 1
sum(probs)

# might end up with .9999999999 because of floating point
#Can instead calculate rational Ints, i.e. fractions

probs = data .// 10^7

sum(probs) # returns 1//1 or 1

# plot data/sum(data) (vectorized with .)

plot(0:length(data)-1, data ./sum(data), m=:O)

using Statistics

mean(results) # n = 20 trials

#Expectation is expected mean value of N*p
