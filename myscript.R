# ds 2020-03-22 / based on r/leaflet 
library(leaflet)
library(htmlwidgets)
library(readr)
library(tibble)

# minimal geo example - export to HTML

d <- tibble(lng=-1.134304, lat=52.932834,name="Henry Road", code="NG2")

#
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=d$lng, lat=d$lat, popup=paste(d$name, ':', d$code ))
m  # Print the map

# save out / render.
saveWidget(widget=m,
           file="map1.html",
           selfcontained=TRUE)

# backup info to mv out of docker container
write_csv(d, 'markers.csv')

