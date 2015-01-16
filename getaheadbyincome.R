### read in gss data
load(url("http://bit.ly/dasi_gss_data"))

### subset 2012 data
gss06 <- subset(gss, gss$year == "2006")
gss08 <- subset(gss, gss$year == "2008")
gss10 <- subset(gss, gss$year=="2010")
gss12 <- subset(gss, gss$year=="2012")

### exploratory analyses
table(gss12$income06)
byincome12 <- with(gss12, table(getahead, income06))
prop.table(byincome12, 2)
byincomeprop <- as.data.frame(prop.table(byincome12, 2))
byincomeprop[,3] <- byincomeprop[,3]*100 ## turns the freqency into a percentage
colnames(byincomeprop) <- c("getahead", "income", "percent")
ftable(table(gss12$income06, gss12$getahead))
inclevels <- levels(byincomeprop$income) ## remember the income levels
levels(byincomeprop$income) <- 1:26 # rename the income levels so that the graph is easier to read
ginc <- ggplot(byincomeprop, aes(x=income06, y=Freq, group=getahead, color=getahead)) + geom_line(size=1.5) + geom_point(size=3)


g2 <- ggplot(gss12) +geom_bar(aes(x=income06, fill=getahead))