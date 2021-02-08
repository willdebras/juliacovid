using CSV
using DataFrames
using Interact


url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"


download(url, "covid_data.csv")

readdir()

covid_data = CSV.read("covid_data.csv")

DataFrames.rename!(covid_data, 1 => "Province", 2 => "Country")

countries = collect(covid_data[:, 2])

unique_countries = unique(countries)

@manipulate for i = 1:length(countries)
    covid_data[i, 1:5]
end

#array comprehension
#create a boolean array based on the starstwith()

u_countries = [startswith(country, "U") for country in countries]

#then lets subset based on that boolean

covid_data[u_countries, :]

#broadcasting babey

countries .== "US"

us_index = findfirst(countries .== "US")

us_data_row = covid_data[us_index, :]

#convert's first argument is a type, second is object

us_data = convert(Vector, us_data_row[5:end])

using Plots

plot(us_data)

# extract dates

#apply string function to all elements, only get 5 through end

date_strings = String.(names(covid_data))[5:end]

using Dates

format = Dates.DateFormat("m/d/Y")

# believes the year in 0020, so add 2000

dates = parse.(Date, date_strings, format) + Year(2000)

plot(
    dates,
    us_data,
    xticks = dates[1:31:end],
    xrotation = 45,
    leg = :topleft,
    label = "US data",
    uscale = log10,
)

xlabel!("date")
ylabel!("confirmed cases in U.S. (log)")
title!("US confirmed COVID-19 cases")

# functionalize this

function f(country)
    @show country
end
