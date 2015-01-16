### read in gss data
load(url("http://bit.ly/dasi_gss_data"))

### subset 2012 data
gss06 <- subset(gss, gss$year == "2006")
gss08 <- subset(gss, gss$year == "2008")
gss10 <- subset(gss, gss$year=="2010")
gss12 <- subset(gss, gss$year=="2012")

### exploratory analysis
table(gss12$partyid, gss12$getahead)
prop.table(table(gss12$partyid, gss12$getahead),1)
bypartypropdf <- as.data.frame(prop.table(table(gss12$partyid, gss12$getahead),1))
colnames(bypartypropdf) <- c("party", "getahead", "prop")
g3 <- ggplot(bypartypropdf, aes(x=party, y=prop, group=getahead, color=getahead))+geom_line(size=1.5)
g4 <-ggplot(bygetaheaddf, aes(x=getahead, y=prop, group=party, color=party))+geom_line(size=1.5)
partyprop <- as.data.frame(prop.table(table(gss12$partyid)))
colnames(partyprop) <- c("party", "partyprop")
props <- merge(bypartypropdf, partyprop)

### pie charts
### visualization of the general population and belief in hard work
propgetahead <- as.data.frame(prop.table(table(gss12$getahead)))
pie(propgetahead$Freq, labels=propgetahead$Var1)

### barplot of political party affiliation
barplot(table(gss12$partyid))

### percentage of party id that believe in hard work
prop.table(table(gss12$getahead, gss12$partyid), 2)
partyidbywork <- as.data.frame(prop.table(table(gss12$getahead, gss12$partyid), 2))
colnames(partyidbywork) <- c("work", "party", "prop")
with(partyidbywork, qplot(work, prop, data=partyidbywork, facets=.~party))

### subset based on getahead
hardwork12 <- subset(gss12, gss12$getahead == "Hard Work")

### subset getahead and partyid data
workingdata <- gss12[,c("getahead", "partyid")]