#Visualization

##Required Libraries: 'dplyr', 'ggplot2'

##The uncommented commands below are applied to the 'renamed_Beer_Brew' and 'merged_Med_ABV_IBU_byState' data frames from the Data Cleaning and Analysis procedures in 'Beer_Brew_Cleaning.R' and 'Beer_Brew_Analysis.R'.
##The necessary code to run the commands is here reproduced for viewing convenience.

###library(dplyr)
###attach(Breweries)
###attach(Beers)
###renamed_Breweries <- rename(Breweries, replace = c("Brew_ID" = "Brewery_ID"))
###renamed_Beers <- rename(Beers, replace = c("Brewery_id" = "Brewery_ID"))
###Beer_Brew <- merge(x = renamed_Beers, y = renamed_Breweries, by = "Brewery_ID", all = T)
###renamed_Beer_Brew <- rename(Beer_Brew, replace = c("Name.x" = "Beer", "Name.y" = "Brewery"))

###Med_ABVbyState <- aggregate(ABV ~ State, data = renamed_Beer_Brew, FUN = median)
###Med_IBUbyState <- aggregate(IBU ~ State, data = renamed_Beer_Brew, FUN = median)
###merged_Med_ABV_IBU_byState <- merge(x = Med_ABVbyState, y = Med_IBUbyState, by = "State", all = T)


##Using the merged data frame of median Alcohol-by-Volume and International Bitterness Units values, a column plot of the two measures colored and labeled by State is produced for comparison.

library(ggplot2)

ABV_v_IBU <- ggplot(merged_Med_ABV_IBU_byState, aes(IBU, ABV, group = State)) + geom_col(aes(fill = State), position = "dodge") + geom_text(aes(label = State), position = "dodge", size = 2)
ABV_v_IBU

###With a few outliers, the figure demonstrates a roughly uniform distribution of ABV to IBU across States. Note that records with missing ABV or IBU values are excluded.


##Using the merged Beers and Breweries data frame, a scatterplot of Alcohol-by-Volume and International Bitterness Units values colored and labeled by State is produced for comparison.

ABV_v_IBU_Scatter <- ggplot(renamed_Beer_Brew, aes(IBU, ABV, label = State)) + geom_text(size = 1, check_overlap = T) + geom_label(aes(fill = State), color = "black", label.padding = unit(.1, "lines"), label.size = .1)
ABV_v_IBU_Scatter

###Excepting the outliers, a relatively strong positive quadratic trend in correlation is identifiable in this figure, with the rate of increase in ABV slowing as IBU increases. As before, the figure omits records with missing ABV or IBU values, including the ABV maximum discovered in the Analysis procedures.
