df <- data.frame()
x <- data.frame()
proportions <- function(YEAR , Var1, Var2){ 
    load(url("http://bit.ly/dasi_gss_data"))
    gss$year <- as.character(gss$year)
    x <- subset(gss, gss$year == YEAR)
    uniondf <- as.data.frame(table(x$union, x$getahead))
    unionmem <- as.data.frame(table(x$union))
    colnames(uniondf) <-c("union", "getahead", "inter")
    colnames(unionmem) <- c("union", "membership")
    uniondf2 <- merge(uniondf, unionmem)
}