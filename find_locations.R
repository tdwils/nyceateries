# find_locations.R

# This script will find the latitude and longitude for a list of addresses.


library(ggmap)

# ggmap requires a Google Maps API key.
# Never save your API key in a script.
# Run the following command with your own API key.
register_google(key = "INSERT_GOOGLE_API_KEY_HERE")

eateries <- read.csv("data/eateries.csv", 
                    header = TRUE, 
                    stringsAsFactors = FALSE)

geodata <- mutate_geocode(eateries, address)

write.csv(x = geodata, file = "data/geodata.csv", row.names = FALSE)

