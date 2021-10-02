using Plots
using Random
using Statistics
using Distributions

# Custom type for Circle. Keeping it orginized
struct Circle
    x::Float64
    y::Float64
    r::Float16
end

# Custom type for Square
struct Square
    x::Float64
    y::Float64
    a::Float16
end

function give_sample(n=1, from=0, to=9)
    return rand(Uniform(from, to), n)
end

function give_sample(n=1, from_to::Tuple=(0,9))
    return rand(Uniform(from_to[1], from_to[2]), n)
end

function pi_search(plane::Vector{Vector{Float64}}, number_of_samples::Int=100, sampling::Int=10, from_to::Tuple=(0, 9))
    # We are generating *number_of_samples* number of coordinates and
    # store them in th *plane*
    for i = 1:number_of_samples
        push!(plane, give_sample(2, from_to))
    end
end

function pi_search(number_of_samples::Int=1000, from_to::Tuple=(0,10))
    plane_x = Vector{Float64}()
    plane_y = Vector{Float64}()
    # We are generating *number_of_samples* number of coordinates and
    # store them in th *plane*
    for i = 1:number_of_samples
        append!(plane_x, give_sample(1, from_to))
        append!(plane_y, give_sample(1, from_to))
    end
    plane = [plane_x, plane_y]
    return plane
end

# Function for checking if ball falls inside the circle
function is_inside(circle::Circle, x, y)
    return sqrt((circle.x - x)^2 + (circle.y - y)^2) < abs(circle.r)
end

function is_inside(square::Square, x, y)
    square_r = square.a/2

    if x > square.x - square_r && y > square.y - square_r
        
        if y < square.y + square_r && x < square.x + square_r
            return true
        else
            return false
        end
    else 
        return false
    end
end

function square_cords(square::Square)
    square_r = square.a/2

    x = [
        [square.x - square_r, square.x - square_r, square.x + square_r, square.x + square_r, square.x - square_r],
        [square.y - square_r, square.y + square_r, square.y + square_r, square.y - square_r, square.y - square_r]
    ]
    show(x)
    return x
end

function main()
    our_circle = Circle(5, 5, 5)
    our_square = Square(5, 5, 5)

    samples_circle = 0
    samples_square = 0

    NUMBER_OF_SAMPLES = 1000000
    samples = pi_search(NUMBER_OF_SAMPLES, (0, 10))

    for i = 1:NUMBER_OF_SAMPLES
        # if i%100000 == 0
        #     samples = pi_search(NUMBER_OF_SAMPLES, (0, 10))
        # end
        if is_inside(our_circle, samples[1][i], samples[2][i])
            samples_circle += 1
        end
        if is_inside(our_square, samples[1][i], samples[2][i])
             samples_square += 1
        end
    end

    println(samples_circle/samples_square)
end

main()