#Summary Statistics

##The number of unique Breweries per State are aggregated and returned.

attach(Breweries)

Breweries_per_State <- aggregate(Name ~ State, data = Breweries, FUN = length)
Breweries_per_State


##The uncommented commands below are applied to the 'renamed_Beer_Brew' data frame from the Data Cleaning procedure in 'Beer_Brew_Cleaning.R'.
##The necessary code to run the commands is here reproduced for viewing convenience.

###library(dplyr)
###attach(Breweries)
###attach(Beers)
###renamed_Breweries <- rename(Breweries, replace = c("Brew_ID" = "Brewery_ID"))
###renamed_Beers <- rename(Beers, replace = c("Brewery_id" = "Brewery_ID"))
###Beer_Brew <- merge(x = renamed_Beers, y = renamed_Breweries, by = "Brewery_ID", all = T)
###renamed_Beer_Brew <- rename(Beer_Brew, replace = c("Name.x" = "Beer", "Name.y" = "Brewery"))


##The number of missing values across features of the merged Beers and Breweries data frame is verified below.

NA_counts<- sapply(renamed_Beer_Brew, function(x) sum(is.na(x)))
NA_counts

##Summary statistics of the Alcohol-by-Volume properties of beer from the merged Beers and Breweries data frame are registered below.

ABV_Stats <- summary(renamed_Beer_Brew$ABV)
ABV_Stats