#Data Cleaning

##Required Libraries: 'dplyr'

library(dplyr)

attach(Breweries)
attach(Beers)

##Name properties of data on Beers and Breweries are checked to resolve discrepancies for merging by key variable, 'Brewery_ID'.

names(Breweries)
renamed_Breweries <- rename(Breweries, replace = c("Brew_ID" = "Brewery_ID"))
names(renamed_Breweries)

names(Beers)
renamed_Beers <- rename(Beers, replace = c("Brewery_id" = "Brewery_ID"))
names(renamed_Beers)

Beer_Brew <- merge(x = renamed_Beers, y = renamed_Breweries, by = "Brewery_ID", all = T)
names(renamed_Beers)

##Duplicate 'Name' variables created by the merge are differentiated into names of Beer labels and names of Breweries.

renamed_Beer_Brew <- rename(Beer_Brew, replace = c("Name.x" = "Beer", "Name.y" = "Brewery"))
names(renamed_Beer_Brew)

##Head and Tail of merged data sets are viewed to verify a successful merge.

head(renamed_Beer_Brew)
tail(renamed_Beer_Brew)