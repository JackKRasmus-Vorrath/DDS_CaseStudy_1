#Case Study of 2410 craft beers and 558 breweries from the United States

##This case study summaries, analyzes, and visualizes data on craft beers from breweries across the United States.
##From the available data, the study registers the number of unique breweries per state, calculates median and maximum Alcohol-by-Volume (ABV) and International Bitterness Units (IBU) values by state, and visualizes these measures across states for comparison. 


###Version/Environment Information
####Required Libraries not included in Base R: 'plyr', 'ggplot2' 
#```{r User Info}
R.version
print((.packages()))
#```

###Raw Data Import
####Note that local file paths must be adjusted to represent the user's directory structure.
#```{r Import}

Beers <- read.csv("C:/Users/jkras/Desktop/R_Docs/R_Projects/DDS_CaseStudy_1/Raw_Data/Beers.csv")
Breweries <- read.csv("C:/Users/jkras/Desktop/R_Docs/R_Projects/DDS_CaseStudy_1/Raw_Data/Breweries.csv")
#```


###The first question of interest concerned the number of unique breweries per state.
####The spread is from 1 (SD, ND, WV, DC) to 47 (CO), with Colorado far surpassing the number in other states; California comes in at second with 39.
#```{r Question 1}

attach(Breweries)

Breweries_per_State <- aggregate(Name ~ State, data = Breweries, FUN = length)
Breweries_per_State 
#```


###Producing summary statistics of interest required cleaning up feature names of the two data frames to merge them by a Brewery identifier key, 'Brewery_ID'.
###The head and tail of the resulting data frame was checked to verify a successful merge.
#```{r Question 2}

library(plyr)

attach(Breweries)
names(Breweries)
renamed_Breweries <- rename(Breweries, replace = c("Brew_ID" = "Brewery_ID"))
names(renamed_Breweries)

attach(Beers)
names(Beers)
renamed_Beers <- rename(Beers, replace = c("Brewery_id" = "Brewery_ID"))
names(renamed_Beers)

Beer_Brew <- merge(x = renamed_Beers, y = renamed_Breweries, by = "Brewery_ID", all = T)
names(Beer_Brew)

renamed_Beer_Brew <- rename(Beer_Brew, replace = c("Name.x" = "Beer", "Name.y" = "Brewery"))
names(renamed_Beer_Brew)

head(renamed_Beer_Brew)
tail(renamed_Beer_Brew)
#```


###A summary of the missing feature values of the clean merged data frame was conducted before proceeding with analysis.
####Missing values included 62 records without measures for Alcohol-by-Volume, and 1005 records without measures for International Bitterness Units.
#```{r Question 3}

NA_counts<- sapply(renamed_Beer_Brew, function(x) sum(is.na(x)))
NA_counts
#```


###Analysis of particular features of the data included an evaluation and visualization of median Alcohol-by-Volume and International Bitterness Units values of beers by state.
####With a few exceptions, the figure demonstrated a roughly uniform distribution of the relation between median ABV and IBU across states.
####While median bitterness ranged between approximately 20 (WI) and 60 (ME) IBU, median ABV ranged from roughly .04 to .06.
#```{r Question 4}

library(ggplot2)

Med_ABVbyState <- aggregate(ABV ~ State, data = renamed_Beer_Brew, FUN = median)
Med_ABVbyState

Med_IBUbyState <- aggregate(IBU ~ State, data = renamed_Beer_Brew, FUN = median)
Med_IBUbyState

merged_Med_ABV_IBU_byState <- merge(x = Med_ABVbyState, y = Med_IBUbyState, by = "State", all = T)
merged_Med_ABV_IBU_byState

ABV_v_IBU <- ggplot(merged_Med_ABV_IBU_byState, aes(IBU, ABV, group = State)) + geom_col(aes(fill = State), position = "dodge") + geom_text(aes(label = State), position = "dodge", size = 2) + labs(title = "Median ABV|IBU by State", subtitle = "Records with Missing Values Excluded")
ABV_v_IBU
#```


###Analysis also included an evaluation of maximum Alcohol-by-Volume and International Bitterness Units values of beers by state, and across all states.
####Colorado again sets a precedent with a maximum .128 ABV value, with Kentucky in a close second (.125).
####Meanwhile, Oregon asserts its place as the state producing the most bitter of beers with an IBU of 138; Virgina takes a close second, producing a beer with IBU of 135.
#```{r Question 5}

Max_ABVbyState <- aggregate(ABV ~ State, data = renamed_Beer_Brew, FUN = max)
Max_ABVbyState

Max_ABV_All <- max(Max_ABVbyState$ABV)
Max_ABV_All
Max_ABV_All_row <- subset(Max_ABVbyState, ABV == .128)
Max_ABV_All_row

Max_IBUbyState <- aggregate(IBU ~ State, data = renamed_Beer_Brew, FUN = max)
Max_IBUbyState

Max_IBU_All <- max(Max_IBUbyState$IBU)
Max_IBU_All
Max_IBU_All_row <- subset(Max_IBUbyState, IBU == 138)
Max_IBU_All_row
#```


###Summary statistical measures of Alcohol-by-Volume values for all beers across states were also evaluated.
####The distribution of ABV values ranges from 0.001 to Colorado's 0.128, and is only slightly right skewed, with an overall median and mean ABV of 0.056 and 0.05977, respectively.
#```{r Question 6}

ABV_Stats <- summary(renamed_Beer_Brew$ABV)
ABV_Stats
#```


###A final visualization was produced of the relation between Alcohol-by-Volume and International Bitterness Units values of beers across states.
####Excepting outliers, and bearing in mind records with missing ABV or IBU values excluded from the figure, the scatterplot indicated a relatively strong quadratic negative correlation between the two measures of interest.
#```{r Question 7}

library(ggplot2)

ABV_v_IBU_Scatter <- ggplot(renamed_Beer_Brew, aes(IBU, ABV, label = State)) + geom_text(size = 1, check_overlap = T) + geom_label(aes(fill = State), color = "black", label.padding = unit(.1, "lines"), label.size = .1) + labs(title = "ABV|IBU by State", subtitle = "Records with Missing Values Excluded")
ABV_v_IBU_Scatter
#```


####On the whole, the data suggested that tastes for beer in the U.S. are as diverse as the demographics of its states.
###However, no matter where one chooses to imbibe, the relation between bitterness and bigger buzz holds only to a certain point!

