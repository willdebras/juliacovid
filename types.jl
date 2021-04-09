# user defined types
mutable struct DiscreteWalker #Types are camel case
    x::Int64
end

DiscreteWalker # refers to type

methods(DiscreteWalker) # julia automatically made two constructor methods

# created a function with this name that creates objects of this type
w = DiscreteWalker(3)

typeof(w)

Complex(3, 4)
 # is same thign as 3 + 4im (im is i, sqrt -1)

 @which Complex(3, 4)

 # can check type with isa

 w isa DiscreteWalker

DiscreteWalker(3.0) # will try to coerce

# performs typecasting

DiscreteWalker("3.0") # cannot handle all conversion calls

# can truncate

trunc(Int64, 3.1) # returns int
floor(3.1) # this will still return floating

#immutable structs perform a lot better

# defining new methods

DiscreteWalker() = DiscreteWalker(0) # outer constructor (lives outside definition of type)

function jump!(w::DiscreteWalker)
    w.x += rand((-1,+1))
end

pos(w::DiscreteWalker) = w.x # can create an interface to an object without details

w.x

pos(w)

# method to set position

function set_pos!(w)
    w.x = x
end

# never need internal details of object in this new version of `jump`

function jump!(w::DiscreteWalker)
    old_pos = pos(w)
    set_pos!(old_pos + jump(w))
end

function walk!(w::DiscreteWalker, N)
    for i in 1:N
        jump!(w)
    end

    return w
end

methods(walk!)

walk!(w, 10)

## continuous walker

mutable struct MyContinuousWalker
    y::Float64
end

w = MyContinuousWalker(3.0)

w isa MyContinuousWalker

jump!(w)

jump(w::MyContinuousWalker) = randn()

function jump!(w)
    old_pos = pos(w)
    set_pos!(w, old_pos + jump(w))
end

pos(w::MyContinuousWalker) = w.y

function set_pos!(w::MyContinuousWalker)
    w.y = pos
end

jump!(w)

# errors because we over-typed, lets remove the type restrictions
walk!(w, 10)

function walk!(w::MyContinuousWalker, N)
    for i in 1:N
        jump!(w)
    end
    return w
end

walk!(w, 15)

jump(w)
