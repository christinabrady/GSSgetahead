## yearly change in get ahead

## subset the data based on $getahead and year
var <- c("year", "getahead")
getyr <- gss[, colnames(gss) %in% var]

#calculate the number of people who believe in each option in each year
tables <- with(getyr, tapply(getahead, year, table))
df <- data.frame(prop.table(matrix(unlist(tables), nrow=length(tables), byrow=T),1))
df[,1:3] <- df[,1:3]*100  #to turn them into percentages instead of decimals
dfm <- melt(df)
colnames(dfm) <- c("year", "getahead", "percent")
dfm$year <- as.factor(dfm$year) #convert to factor in order to use ggplot2
dfm$getahead <- as.factor(dfm$getahead) #convert to factor in order to use ggplot2
## rename the year with only 2 digits so that it is easier to read in the graph
years <- levels(dfm$year)
yr <- gsub("19", "", years)
yr <- gsub("20", "", yr)
yr <- as.numeric(yr)
levels(dfm$year) <- yr
### drop the years that have no info for $getahead
dfmcomplete <- dfm[complete.cases(dfm),] ### gets rid of the NaN values

library(ggplot2)
g <- ggplot(dfmcomplete, aes(x=year, y=percent, colour=getahead, group=getahead)) + geom_line()
g



## another option to conver to data frame that keeps the proper structure
df2 <- ldply(tables, data.frame)
colnames(df2) <- c("year", "getahead", "Freq")