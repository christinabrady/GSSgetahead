
---
title: "How people get ahead is dependent on your politics"
date: "October 19, 2014"
output:
  pdf_document:
    theme: cerulean
---

<!-- For more info on RMarkdown see http://rmarkdown.rstudio.com/ -->

<!-- Enter the code required to load your data in the space below. The data will be loaded but the line of code won't show up in your write up (echo=FALSE) in order to save space-->

```r
load(url("http://bit.ly/dasi_gss_data"))
library(ggplot2)
```

<!-- In the remainder of the document, add R code chunks as needed -->

### Introduction:

The belief that if you work you, you will get ahead in life is a powerful narrative that shapes American culture. I suspect that this translates into a value, a belief in hard work as THE way to get ahead in life, that informs Americans' opinions about policies as diverse as health care, foreign aid, taxes, public education, social security, and many others. For example, a person may be less likely to support welfare programs if he or she believes that people get ahead solely via their own hard work.  

Opinions about policies are a component of political party affiliation in the United States, though they are not the only component, nor necessarily the determining factor. There is a sense that the Democrats support more social programming and "help" for poor and underpriveledged while the Republicans want to undermine these programs. Thus, I am interested in analyzing the interaction between the belief in hard work as the way to get ahead and political party affiliationin the U.S. 

### Data:
For this study, I will use the General Social Survey (GSS) data from 2012.  The GSS data includes information about people's opinions and sentiments regarding a number of different topics that are important to people living in the U.S. Each observation (case) represents one person who was interviewed, and the variables are the different values or opinions about which he or she was questioned.   

The information is gathered through field interviews. Field interviewers conduct interviews that last about 1.5 hours at the homes of the respondents. The field interviewers are assigned to geographic areas and instructed to canvass or conduct interviews after 3pm on weekdays (Monday - Friday) or during weekends or holidays. They move from house to house attempting to interview people until they have completed interviews with a specific numbers of participants of different ages, sex and employment status. The interviewers conduct the interviews in English and Spanish with participants 18 years or older who are not living in institutional settings (military barracks, college dorms, nursing homes, etc.) The designers of the study set the quotas for each field interviewer and geographic location so that the proportions of respondents of different ages, sexes and employment statuses resemble the U.S. Census.  

This is an observational study; therefore, it cannot estabilish causality. However, the participants are randomly sampled via blocking and the sample is large enough to make it generalizable to the population of interest: English and/or Spanish speaking population of the United States that is over 18 and not living in an institutional setting.  

To analyze how the belief in hard work as a way to get ahead varies according to one's affiliation with a political party, I will use the variables "getahead" and "partyid". For the purposes of this study, I will refer to the two variables as "belief in hard work", and "political party" respectively.  

In order to make the data more manageable, I have extracted only the two variables that I will be analyzing the 2012 GSS data using the following code. 


```r
gss12 <- subset(gss, gss$year=="2012")
gss12.1 <- gss12[, c(29, 79)]
```

The citation for the GSS data is:  
Smith, Tom W., Michael Hout, and Peter V. Marsden. General Social Survey, 1972-2012 [Cumulative File]. ICPSR34802-v1. Storrs, CT: Roper Center for Public Opinion Research, University of Connecticut /Ann Arbor, MI: Inter-university Consortium for Political and Social Research [distributors], 2013-09-11. doi:10.3886/ICPSR34802.v1 Persistent URL: http://doi.org/10.3886/ICPSR34802.v1 

### Exploratory data analysis:

The GSS assesses the belief in hard work by asking the following question:   "Some people say that people get ahead by their own hard work; others say that lucky breaks or help from other people are more important. Which do you think is most important?"  The possible responses are:

- Hard Work
- Both equally
- Luck or help
- other
- Don't know
- NA

The number and proportion of respondents who chose each response can be seen in the table below. The first column is the response. The second column is the total number of respondents who chose that response. The last column is the proportion of the total number of respondents who chose that reponse. 


```r
getahead <- as.data.frame(table(gss12.1$getahead))
colnames(getahead)<- c("Var1", "Total")
getahead2 <- merge(getahead, as.data.frame(prop.table(table(gss12.1$getahead))))
colnames(getahead2) <- c("Response", "Total", "Proportion")
getahead2
```

```
##       Response Total Proportion
## 1 Both Equally   264    0.20276
## 2    Hard Work   910    0.69892
## 3 Luck Or Help   128    0.09831
## 4        Other     0    0.00000
```

Since none of the respondents chose "Other" or "Don't Know", I have eliminated them from the data that I will be working with along with NA values.


```r
gss12.2 <- droplevels(gss12.1)
gss12.2 <- na.omit(gss12.2)
```

The GSS assesses political party affiliation by asking, "Generally speaking, do you usually think of yourself as a Republican, Democrat, Independent, or what?"  The possible responses are:  
- Strong Democrat
- Not Strong Democrat
- Independent, near Dem
- Independent
- Independent, near Rep
- Not Strong Republican
- Strong Republican
- Other party
- Don't know

Those same respondents chose the their political party affiliation in the following the following manner: 


```r
party <- as.data.frame(table(gss12.2$partyid))
colnames(party)<- c("Party", "Total")
party
```

```
##                Party Total
## 1    Strong Democrat   236
## 2   Not Str Democrat   221
## 3       Ind,Near Dem   141
## 4        Independent   254
## 5       Ind,Near Rep   105
## 6 Not Str Republican   165
## 7  Strong Republican   133
## 8        Other Party    36
```


When we break the responses into their respective political party afilliation and compare the proportions of people who believe in "hard work", "both equally", or "luck or help" respectively, we can see a trend. If the two variables are independent, the proportion of people who choose "Hard Work" as the way to get ahead should not vary significantly from the overall proportions of 69.89%, 20.27% and 9.83% for "Hard Work", "Both Equally", and "Luck or Help" respectively.  


```r
df <- as.data.frame(prop.table(table(gss12.2$partyid, gss12.2$getahead),1))
colnames(df) <- c("party", "getahead", "proportion")
levels(df$party) <- c("SD", "NSD", "ID", "I", "IR", "NSR", "SR", "OTHER", "DK")
g <- ggplot(df, aes(x=party, y=proportion, group=getahead, fill=getahead))+geom_bar(stat="identity")+scale_fill_brewer(palette="Spectral")
g
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 

However, as we move from "Strong Democrat" to "Not Strong Republican" until we get to people who identify as "Strong Republican" or "Other", the proportion of people who chose "Hard Work" as the way to get ahead gradually increases. This suggests that one's belief in hard work as the way to get ahead and one's political party affiliation are not independent. 

### Inference:
To test this hypothesis, it is important to state the null and alternative hypotheses. 

The null hypothesis, H0, is that belief in hard work and political party affiliation are independent. The proportion of people who believe in hard work as the primary way to get ahead should not vary across political party identification. Approximately 70% (69.89) of people surveyed should believe in "hard work", 20% (20.28) should believe in "both equally", 10% (9.83) should believe in "luck or help".     

The alternative hypothesis, HA, is that belief in hard work and political party affiliation are associated. Thus, the proportion of people who believe in "hard work" as the way to get ahead will differ according to political affiliation.  

In order to assess the independence or association of two categorical values each with two or more levels, the chi-square is the most appropriate test. 

All of the conditions are met except one. Since this data is randomly sampled and less than 10% of the population, we can assume that the observations are independent. The degrees of freedom are (8-1)*(3-1)=14. 14 is greater than 1 so it meets the degrees of freedom condition. The unmet condition is that of each cell containing at least 5 expected counts. The following table shows the expected counts for each cell. 


```r
tbl <- table(gss12.2)
expected <- as.array(margin.table(tbl, 1)) %*% t(as.array(margin.table(tbl, 2)))/margin.table(tbl)
expected
```

```
##                     getahead
## partyid              Hard Work Both Equally Luck Or Help
##   Strong Democrat       164.52       48.077       23.399
##   Not Str Democrat      154.07       45.022       21.912
##   Ind,Near Dem           98.30       28.724       13.980
##   Independent           177.07       51.744       25.184
##   Ind,Near Rep           73.20       21.390       10.411
##   Not Str Republican    115.03       33.613       16.359
##   Strong Republican      92.72       27.095       13.187
##   Other Party            25.10        7.334        3.569
```
Since "Other Party" is the only cell that does not meet the count requirement, and it only accounts for 2.8% of the population, I decided to run two chi-square tests. First, I will conduct a chi-square test on this data. Then, I will eliminate the "Other Party" category and conduct a second chi-square analysis on that data. 

The first chi-square test reports a p-value of 0.033 indicating that we can reject the null hypothesis. 


```r
chisq.test(tbl)
```

```
## Warning: Chi-squared approximation may be incorrect
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  tbl
## X-squared = 25.19, df = 14, p-value = 0.03274
```

I eliminated the "Other Party" category and calculated the expected counts via the following code:


```r
gss12.3 <- subset(gss12.2, gss12.2$partyid != "Other Party")
gss12.3 <- droplevels(gss12.3)
tbl.2 <- table(gss12.3)
expected.2 <- as.array(margin.table(tbl.2, 1)) %*% t(as.array(margin.table(tbl.2, 2)))/margin.table(tbl.2)
expected.2
```

```
##                     getahead
## partyid              Hard Work Both Equally Luck Or Help
##   Strong Democrat       165.29        47.58        23.13
##   Not Str Democrat      154.79        44.55        21.66
##   Ind,Near Dem           98.76        28.42        13.82
##   Independent           177.90        51.20        24.89
##   Ind,Near Rep           73.54        21.17        10.29
##   Not Str Republican    115.57        33.26        16.17
##   Strong Republican      93.15        26.81        13.04
```

The results of the chi-square test when I eliminate the "Other Party" category are as follows: 

```r
chisq.test(tbl.2)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  tbl.2
## X-squared = 23.09, df = 12, p-value = 0.02698
```

### Conclusion:
Since both p-values are smaller than the significance level, we can safely reject the null hypothesis that political party affiliation and the belief in hard work as the way to get ahead are independent. Since, the calculations take into consideration "political party affiliation" as an explanatory variable, it is safe to say that the belief in hard work as the way to get ahead is dependent, in part, on political party affiliation.   

Further analyses may include one's belief in hard work as a function of income, gender, level of education, employment status or belief in hard work as an explanatory variable for support for foreign aid, affirmative action, and social programming, etc.



