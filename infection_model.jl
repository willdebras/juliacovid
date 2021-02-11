#infection_model

#Each individual infects c new peoplee each day

#I_0 = 1 initial infection
# c is our growth rate

#I\_0 = 1 #could use underscore to get subscripts but hm, press tab key to get:
# I₀

I_0 = 1

c = 0.01 # average no of people that each individual affects on each day
 # can think about prob modeling llater

λ =  1 + c # \lambda <TAB>

# remember semi colon supressed output

I_1 = λ * I_0

I_2 = λ * I_1

# iterate these
# julia for loops are fast :)

# array hours

T = 40 # final time

I = zeros(T)

# Julia indexes arrays at 1
# Need the empty array for a for loop.

I[1] = I_0

for n in 1:T-1
    I[n+1] = λ * I[n]

end

I

using Plots

plot(I, m =:O, label = "I[n]", legend=:topleft)

# give default of 20 days

function run_infection(T=20)

    I_0=1
    # functionalize our mathematical model

    I = zeros(T)
    I[1] = I_0

    for n in 1:T-1
        I[n+1] = λ * I[n]

    end

    return(I)

end

day20 = run_infection(20)

plot(day20, m =:O, label = "I[n]", legend=:topleft)

# lets making it so we can scroll a bar to see thee day and return the infections

using Interact

end_T = 200


@manipulate for T in 1:end_T
    I_result = run_infection(T)

    plot(I_result, m=:O)

    xlims!(0, end_T)
    ylims!(0, maximum(I_result))

end


day2000 = run_infection(2000)

# can iterate tthe log10 function to see this is exponential
# (straight line when on a log scale)

plot(log10.(day2000))
ylabel!("log(Iₙ)")


#log of Iₙ is a linear function of N


# Exponential growth assumes there are always more people to infect

# Can use logistic/asymptotic growth


# Each individal will be in contact with a fraction α of the pop.
#At each contact tthere will be a probability p that you infect each person.

# c = p*α*N
# alpha fraction of pop contacted
# number of contacts is α*N

p = 0.02 #prob you infect
α = 0.01 # fraction
N = 1000 # population

β(I, s) = p * α * (N - I)


function run_infection(T=20)

    I_0=1
    I = zeros(T)
    I[1] = I_0

    for n in 1:T-1
        I[n+1] = I[n] + β(I[n], N - I[n]) * I[n]

    end

    return(I)

end

# looks logarithmic

results = run_infection(20)
plot(results, m=:O)

# when given longer time can see its not a log, but a logistic curve
# is a sigmoid shape on base scale

results = run_infection(100)
plot(results, m=:O, yscale =:log10)


# Better models
# heterogeneity of individuals
# Instead of modeling globally, we can model an individual
# Called individual based models

# "Patch model": Local patches where population is well mixed
# "Network model": Similar with links between nodes and each node is a patch

# Let's do an exponential growth model witth growth rate changes in time

p = 0.02 #prob you infect
α = 0.01 # fraction
N = 1000 # population

function run_infection(c_average = 1.1, T=20)

    I_0=1
    I = zeros(T)
    I[1] = I_0

    for n in 1:T-1

        # where c (infection rate) has some randomness
        # rand()
        # randn() gaussian distribution

        c = c_average + 0.1*randn()
        I[n+1] = I[n] + c * I[n]

    end

    return(I)

end

# can look at our random noise

c_average = 1.1
cs = [c_average + 0.1*randn() for _ in 1:100] # underscore in variable is var we dont care about

cs

scatter(cs)
