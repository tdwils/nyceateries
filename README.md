# NYC Eateries

This Shiny app provides an easy way to locate restaurants specified in a CSV file. 

When the user hovers over a marker, the restaurant name is displayed. When the user clicks on a marker, a popup appears with a link to the restaurant's website (if available) and the street address.

Packages used include shiny, leaflet, and ggmap.

A working version of the app can be found here: https://tdwils.shinyapps.io/nyceateries/ 

### To create your own map

The input file "data/eateries.csv" should have these fields: name, url, address, and type.

Use the script findlocations.R to create a file with latitude and longitude data. You will need a Google Maps API key, which you can obtain by following these instructions: https://developers.google.com/maps/documentation/javascript/get-api-key 

### Acknowledgments 

The data are from the blog of David Lebovitz: https://www.davidlebovitz.com/new-york-restaurants-and-bakeries/. Many thanks to Mr. Lebovitz for testing all this great food and compiling the list of eateries. 

Although all the credit for the list goes to Mr. Lebovitz, any errors in this app are solely my own. Before visiting a location, please be sure to verify the information, as businesses often change.
