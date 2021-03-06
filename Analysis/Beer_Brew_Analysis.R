#Analysis

##Required Libraries: 'dplyr'

##The uncommented commands below are applied to the 'renamed_Beer_Brew' data frame from the Data Cleaning procedure in 'Beer_Brew_Cleaning.R'.
##The necessary code to run the commands is here reproduced for viewing convenience.

###library(dplyr)
###attach(Breweries)
###attach(Beers)
###renamed_Breweries <- rename(Breweries, replace = c("Brew_ID" = "Brewery_ID"))
###renamed_Beers <- rename(Beers, replace = c("Brewery_id" = "Brewery_ID"))
###Beer_Brew <- merge(x = renamed_Beers, y = renamed_Breweries, by = "Brewery_ID", all = T)
###renamed_Beer_Brew <- rename(Beer_Brew, replace = c("Name.x" = "Beer", "Name.y" = "Brewery"))


##The median value of Alcohol-by-Volume of beer by State from the merged Beers and Breweries data frame is calculated and registered below.

Med_ABVbyState <- aggregate(ABV ~ State, data = renamed_Beer_Brew, FUN = median)
Med_ABVbyState

##The median value of International Bitterness Units of beer by State from the merged Beers and Breweries data frame is likewise calculated and registered below.

Med_IBUbyState <- aggregate(IBU ~ State, data = renamed_Beer_Brew, FUN = median)
Med_IBUbyState

##The data frames produced by the median calculations are merged by State for viewing convenience.

merged_Med_ABV_IBU_byState <- merge(x = Med_ABVbyState, y = Med_IBUbyState, by = "State", all = T)
merged_Med_ABV_IBU_byState


##The maximum value of Alcohol-by-Volume of beer by State from the merged Beers and Breweries data frame is calculated and registered below.

Max_ABVbyState <- aggregate(ABV ~ State, data = renamed_Beer_Brew, FUN = max)
Max_ABVbyState

##From the data frame produced by the maximum-by-State calculation, the maximum value of Alcohol-by-Volume of beer across all States is calculated and registered below.

Max_ABV_All <- max(Max_ABVbyState$ABV)
Max_ABV_All

##The State associated with this overall maximum Alcohol-by-Volume value is verified.

Max_ABV_All_row <- subset(Max_ABVbyState, ABV == .128)
Max_ABV_All_row


##The maximum value of International Bitterness Units of beer by State from the merged Beers and Breweries data frame is calculated and registered below.

Max_IBUbyState <- aggregate(IBU ~ State, data = renamed_Beer_Brew, FUN = max)
Max_IBUbyState

##From the data frame produced by the maximum-by-State calculation, the maximum value of International Bitterness Units of beer across all States is calculated and registered below.

Max_IBU_All <- max(Max_IBUbyState$IBU)
Max_IBU_All

##The State associated with this overall maximum International Bitterness Units value is verified.

Max_IBU_All_row <- subset(Max_IBUbyState, IBU == 138)
Max_IBU_All_row