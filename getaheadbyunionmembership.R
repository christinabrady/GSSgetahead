### create a data frame with 3 variables: union membership, get ahead and frequency of each combination
uniondf <- as.data.frame(table(d$union, d$getahead))

### to calculate proportions and add them to the data frame
## 1. create a data frame of a contingency table of union membership
unionmem <- as.data.frame(table(d$union))

## 2. rename the variables in both data frames to allow for merging
colnames(uniondf) <-c("union", "getahead", "inter")
colnames(unionmem) <- c("union", "membership")
uniondf2 <- merge(uniondf, unionmem)

## 3. calculate the proportions of get ahead opinions based on union membership
uniondf2$propbyunion <- uniondf2$inter/uniondf2$membership

## 4. merge the contingency table of get ahead opinions and caluculate the proportions of union membership based on opinion
getaheadtot <- as.data.frame(table(d$getahead))
colnames(getaheadtot) <- c("getahead", "optotal")
uniondf3 <- merge(uniondf2, getaheadtot)
uniondf3$propbyop <- uniondf3$inter/uniondf3$optotal
uniondf3$year <- rep(2012, times=16)

### 1972, 75, 78, 83, 86 have no info for $getahead
### 1972, 74, 82 have no info for $union

